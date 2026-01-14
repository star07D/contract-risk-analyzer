import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../domain/entities/contract_entity.dart';
import '../../domain/services/contract_notification_policy.dart';

class ContractNotificationScheduler {
  final FlutterLocalNotificationsPlugin _notifications;

  ContractNotificationScheduler(this._notifications);

  /// Schedule all notifications for a list of contracts
  Future<void> scheduleForContracts(
      List<ContractEntity> contracts,
      ) async {
    for (final contract in contracts) {
      await _scheduleForContract(contract);
    }
  }

  /// Schedule notifications for a single contract
  Future<void> _scheduleForContract(
      ContractEntity contract,
      ) async {
    final dates =
    ContractNotificationPolicy.notificationDates(contract);

    if (dates.isEmpty) return;

    for (int i = 0; i < dates.length; i++) {
      await _scheduleNotification(
        contract: contract,
        notifyAt: dates[i],
        index: i,
      );
    }
  }

  Future<void> _scheduleNotification({
    required ContractEntity contract,
    required DateTime notifyAt,
    required int index,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'contract_expiry',
      'Contract Expiry Alerts',
      channelDescription: 'Smart contract expiry notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    final details = NotificationDetails(android: androidDetails);

    final scheduledTime = tz.TZDateTime.from(
      notifyAt,
      tz.local,
    );

    // Unique ID per contract + notification index
    final notificationId =
        (contract.id ?? contract.hashCode) * 10 + index;

    await _notifications.zonedSchedule(
      notificationId,
      'Contract expiring soon',
      _notificationBody(contract, notifyAt),
      scheduledTime,
      details,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  String _notificationBody(
      ContractEntity contract,
      DateTime notifyAt,
      ) {
    final daysLeft =
        notifyAt.difference(DateTime.now()).inDays;

    if (daysLeft <= 1) {
      return '${contract.name} renews tomorrow. Take action now.';
    }

    return '${contract.name} renews in $daysLeft days.';
  }
}
