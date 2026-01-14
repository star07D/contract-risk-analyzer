import 'package:drift/drift.dart';

import '../../core/notifications/notification_bootstrap.dart';
import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/repositories/contract_repository.dart';
import '../../domain/services/contract_risk_service.dart';
import '../../domain/services/contract_notification_scheduler.dart';
import '../database/app_database.dart';

class ContractRepositoryImpl implements ContractRepository {
  final AppDatabase db;
  final ContractNotificationScheduler _notificationScheduler;

  ContractRepositoryImpl(
      this.db,
      this._notificationScheduler,
      );

  @override
  Future<List<ContractEntity>> getAllContracts() async {
    final rows = await db.select(db.contracts).get();

    return rows.map((row) {
      //Temporary entity (no real risk yet)
      final temp = ContractEntity(
        id: row.id,
        name: row.name,
        category: ContractCategory.values.firstWhere(
              (e) => e.name == row.category,
          orElse: () => ContractCategory.other,
        ),
        cost: row.cost,
        isMonthlyCost: row.isMonthlyCost,
        startDate: row.startDate,
        minimumDurationMonths: row.minimumDurationMonths,
        noticePeriodDays: row.noticePeriodDays,
        renewalCycleMonths: row.renewalCycleMonths,
        riskLevel: RiskLevel.low, // placeholder
      );

      //Calculate real risk in domain layer
      final calculatedRisk =
      ContractRiskService.calculateRisk(temp);

      //Return final entity
      return ContractEntity(
        id: temp.id,
        name: temp.name,
        category: temp.category,
        cost: temp.cost,
        isMonthlyCost: temp.isMonthlyCost,
        startDate: temp.startDate,
        minimumDurationMonths: temp.minimumDurationMonths,
        noticePeriodDays: temp.noticePeriodDays,
        renewalCycleMonths: temp.renewalCycleMonths,
        riskLevel: calculatedRisk,
      );
    }).toList();
  }

  @override
  Future<void> addContract(ContractEntity contract) async {
    final id = await db.into(db.contracts).insert(
      ContractsCompanion.insert(
        name: contract.name,
        category: contract.category.name,
        cost: contract.cost,
        isMonthlyCost: contract.isMonthlyCost,
        startDate: contract.startDate,
        minimumDurationMonths: contract.minimumDurationMonths,
        noticePeriodDays: contract.noticePeriodDays,
        renewalCycleMonths: contract.renewalCycleMonths,
      ),
    );

    // Schedule notification AFTER successful save
    final savedContract = contract.copyWith(id: id);
    await _notificationScheduler.scheduleForContracts([savedContract]);
  }

  @override
  Future<void> updateContract(ContractEntity contract) async {
    await (db.update(db.contracts)
      ..where((tbl) => tbl.id.equals(contract.id!)))
        .write(
      ContractsCompanion(
        name: Value(contract.name),
        category: Value(contract.category.name),
        cost: Value(contract.cost),
        isMonthlyCost: Value(contract.isMonthlyCost),
        startDate: Value(contract.startDate),
        minimumDurationMonths:
        Value(contract.minimumDurationMonths),
        noticePeriodDays: Value(contract.noticePeriodDays),
        renewalCycleMonths:
        Value(contract.renewalCycleMonths),
      ),
    );

    // Re-schedule notification after update
    await _notificationScheduler.scheduleForContracts([contract]);
  }

  @override
  Future<void> deleteContract(int id) async {
    await (db.delete(db.contracts)
      ..where((tbl) => tbl.id.equals(id)))
        .go();

    // Cancel any scheduled notification for this contract
    await NotificationBootstrap.notifications.cancel(id);
  }
}
