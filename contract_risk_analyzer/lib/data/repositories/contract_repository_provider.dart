import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/contract_repository.dart';
import '../database/database_provider.dart';
import 'contract_repository_impl.dart';

final contractRepositoryProvider = Provider<ContractRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ContractRepositoryImpl(db);
});
