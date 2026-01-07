import '../entities/contract_entity.dart';

abstract class ContractRepository {
  Future<List<ContractEntity>> getAllContracts();

  Future<void> addContract(ContractEntity contract);

  Future<void> updateContract(ContractEntity contract);

  Future<void> deleteContract(int id);
}
