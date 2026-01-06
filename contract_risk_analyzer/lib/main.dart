import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/screens/contracts_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: ContractRiskAnalyzerApp()));
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
