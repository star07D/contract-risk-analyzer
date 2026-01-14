import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/notifications/notification_bootstrap.dart';
import 'presentation/screens/contracts_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationBootstrap.initialize();

  final androidPlugin =
  NotificationBootstrap.notifications
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    await androidPlugin.requestNotificationsPermission();
  }

  runApp(
    const ProviderScope(
      child: ContractRiskAnalyzerApp(),
    ),
  );
}

class ContractRiskAnalyzerApp extends StatelessWidget {
  const ContractRiskAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContractsListScreen(),
    );
  }
}
