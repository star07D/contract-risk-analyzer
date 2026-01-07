import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/contract_repository_provider.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/services/contract_risk_service.dart';
import '../screens/add_contract_screen.dart';
import 'contracts_provider.dart';
import 'risk_summary_screen.dart';

class ContractsListScreen extends ConsumerWidget {
  const ContractsListScreen({super.key});

  Color _riskColor(RiskLevel risk) {
    switch (risk) {
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractsAsync = ref.watch(contractsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contracts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiskSummaryScreen(),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddContractScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: contractsAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contracts) {
          if (contracts.isEmpty) {
            return const Center(child: Text('No contracts added yet'));
          }

          return ListView.builder(
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];
              final risk =
              ContractRiskService.calculateRisk(contract);

              return Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(contract.name),
                  subtitle: Text(
                    '€${contract.cost.toStringAsFixed(2)} '
                        '${contract.isMonthlyCost ? "/ month" : "/ year"}',
                  ),
                  trailing: Chip(
                    backgroundColor: _riskColor(risk),
                    label: Text(
                      risk.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddContractScreen(
                          existingContract: contract,
                        ),
                      ),
                    );
                  },
                  onLongPress: () async {
                    // ✅ SAFE: DB contracts ALWAYS have an ID
                    final id = contract.id!;
                    final repository =
                    ref.read(contractRepositoryProvider);

                    await repository.deleteContract(id);
                    ref.invalidate(contractsProvider);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
