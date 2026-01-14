import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/notifications/notification_bootstrap.dart';
import '../../domain/services/contract_notification_scheduler.dart';
import '../database/database_provider.dart';
import 'contract_repository_impl.dart';

final contractRepositoryProvider = Provider<ContractRepositoryImpl>((ref) {
  final db = ref.watch(databaseProvider);

  final scheduler = ContractNotificationScheduler(
    NotificationBootstrap.notifications,
  );

  return ContractRepositoryImpl(
    db,
    scheduler,
  );
});
