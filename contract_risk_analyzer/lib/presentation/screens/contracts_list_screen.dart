import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/services/contract_risk_service.dart';
import '../../data/repositories/contract_repository_provider.dart';
import 'add_contract_screen.dart';
import '../providers/contracts_provider.dart';
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

  Future<void> _confirmDelete(
      BuildContext context,
      WidgetRef ref,
      ContractEntity contract,
      ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contract'),
        content: Text(
          'Are you sure you want to delete "${contract.name}"?\n\n'
              'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      final repository = ref.read(contractRepositoryProvider);
      await repository.deleteContract(contract.id!);
      ref.invalidate(contractsProvider);
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
            tooltip: 'Risk Summary',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiskSummaryScreen(),
                ),
              );
            },
          ),
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
            return const Center(
              child: Text('No contracts added yet'),
            );
          }

          return ListView.builder(
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];
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
                    '€${contract.cost.toStringAsFixed(2)} '
                        '${contract.isMonthlyCost ? "/ month" : "/ year"}',
                  ),
                  trailing: Chip(
                    backgroundColor: _riskColor(risk),
                    label: Text(
                      risk.name.toUpperCase(),
                      style:
                      const TextStyle(color: Colors.white),
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
                  onLongPress: () {
                    _confirmDelete(context, ref, contract);
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
