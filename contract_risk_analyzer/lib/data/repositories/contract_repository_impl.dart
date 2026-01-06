import '../../domain/entities/contract_entity.dart';
import '../../domain/repositories/contract_repository.dart';
import '../database/app_database.dart';

class ContractRepositoryImpl implements ContractRepository {
  final AppDatabase db;

  ContractRepositoryImpl(this.db);

  @override
  Future<List<ContractEntity>> getAllContracts() async {
    final rows = await db.select(db.contracts).get();

    return rows.map((row) {
      return ContractEntity(
        id: row.id, // ✅ int
        name: row.name,
        category: ContractCategory.values
            .firstWhere((e) => e.name == row.category),
        cost: row.cost,
        isMonthlyCost: row.isMonthlyCost,
        startDate: row.startDate,
        minimumDurationMonths: row.minimumDurationMonths,
        noticePeriodDays: row.noticePeriodDays,
        renewalCycleMonths: row.renewalCycleMonths,
      );
    }).toList();
  }

  @override
  Future<void> addContract(ContractEntity contract) async {
    await db.into(db.contracts).insert(
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
  Future<void> deleteContract(int id) async {
    await (db.delete(db.contracts)..where((tbl) => tbl.id.equals(id))).go();
  }
}
