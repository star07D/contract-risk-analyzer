import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/contract_risk_service.dart';
import '../screens/add_contract_screen.dart';
import '../screens/contracts_provider.dart';
import '../../data/repositories/contract_repository_provider.dart';

class ContractsListScreen extends ConsumerWidget {
  const ContractsListScreen({super.key});

  Color _riskColor(RiskLevel risk) {
    switch (risk) {
      case RiskLevel.high:
        return Colors.red;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractsAsync = ref.watch(contractsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contracts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
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
        error: (error, _) =>
            Center(child: Text('Error: $error')),
        data: (contracts) {
          if (contracts.isEmpty) {
            return const Center(
              child: Text(
                'No contracts added yet',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];

              final yearlyCost = contract.isMonthlyCost
                  ? contract.cost * 12
                  : contract.cost;

              final risk =
              ContractRiskService.calculateRisk(contract);

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(contract.name),
                  subtitle: Text(
                    '€${yearlyCost.toStringAsFixed(2)} / year',
                  ),
                  trailing: Chip(
                    label: Text(
                      risk.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _riskColor(risk),
                  ),
                  onLongPress: () async {
                    final repository =
                    ref.read(contractRepositoryProvider);

                    await repository.deleteContract(
                      contract.id!, // ✅ int, NOT string
                    );

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
