import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/database_provider.dart';
import '../../data/repositories/contract_repository_impl.dart';
import '../../data/repositories/contract_repository_provider.dart';
import '../../domain/entities/contract_entity.dart';
import '../../domain/repositories/contract_repository.dart';

/// Provides ContractRepository to the UI layer
final contractsProvider =
FutureProvider.autoDispose<List<ContractEntity>>((ref) async {
  final repository = ref.watch(contractRepositoryProvider);
  return repository.getAllContracts();
});

