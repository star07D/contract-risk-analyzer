import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/services/contract_notification_scheduler.dart';

final contractNotificationSchedulerProvider =
Provider<ContractNotificationScheduler>((ref) {
  final plugin = FlutterLocalNotificationsPlugin();
  return ContractNotificationScheduler(plugin);
});
