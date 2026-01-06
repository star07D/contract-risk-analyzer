import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contract_entity.dart';
import '../../data/repositories/contract_repository_provider.dart';

final contractsProvider =
FutureProvider<List<ContractEntity>>((ref) async {
  final repository = ref.watch(contractRepositoryProvider);
  return repository.getAllContracts();
});
