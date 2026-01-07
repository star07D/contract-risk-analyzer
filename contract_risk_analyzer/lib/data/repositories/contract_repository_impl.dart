import 'package:drift/drift.dart';

import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/repositories/contract_repository.dart';
import '../../domain/services/contract_risk_service.dart';
import '../database/app_database.dart';

class ContractRepositoryImpl implements ContractRepository {
  final AppDatabase db;

  ContractRepositoryImpl(this.db);

  @override
  Future<List<ContractEntity>> getAllContracts() async {
    final rows = await db.select(db.contracts).get();

    return rows.map((row) {
      //Create a temporary entity WITHOUT real risk
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

      //Return FINAL entity
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
  Future<void> addContract(ContractEntity contract) {
    return db.into(db.contracts).insert(
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
  }

  @override
  Future<void> updateContract(ContractEntity contract) {
    return (db.update(db.contracts)
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
  }

  @override
  Future<void> deleteContract(int id) {
    return (db.delete(db.contracts)
      ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
