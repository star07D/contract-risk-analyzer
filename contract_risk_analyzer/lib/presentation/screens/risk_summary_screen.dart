import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/services/contract_risk_service.dart';
import 'contracts_provider.dart';

class RiskSummaryScreen extends ConsumerWidget {
  const RiskSummaryScreen({super.key});

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
        title: const Text('Risk Summary'),
      ),
      body: contractsAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Error: $e')),
        data: (contracts) {
          if (contracts.isEmpty) {
            return const Center(
              child: Text('No contracts available'),
            );
          }

          final summary =
          ContractRiskService.buildSummary(contracts);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _summaryTile(
                  'Total Contracts',
                  summary.totalContracts.toString(),
                ),
                _summaryTile(
                  'Monthly Cost',
                  '€${summary.totalMonthlyCost.toStringAsFixed(2)}',
                ),
                _summaryTile(
                  'Yearly Cost',
                  '€${summary.totalYearlyCost.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 20),
                Text(
                  'Risk Distribution',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                _riskRow(
                  'Low Risk',
                  summary.lowRiskCount,
                  Colors.green,
                ),
                _riskRow(
                  'Medium Risk',
                  summary.mediumRiskCount,
                  Colors.orange,
                ),
                _riskRow(
                  'High Risk',
                  summary.highRiskCount,
                  Colors.red,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Highest Risk: '),
                    Chip(
                      label: Text(
                        summary.highestRisk.name.toUpperCase(),
                        style:
                        const TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                      _riskColor(summary.highestRisk),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _summaryTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _riskRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Chip(
            label: Text(
              count.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: color,
          ),
        ],
      ),
    );
  }
}
