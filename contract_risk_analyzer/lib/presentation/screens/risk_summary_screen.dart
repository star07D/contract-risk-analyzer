import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/services/contract_risk_service.dart';
import '../providers/contracts_provider.dart';

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
      appBar: AppBar(title: const Text('Risk Summary')),
      body: contractsAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contracts) {
          if (contracts.isEmpty) {
            return const Center(
              child: Text('No contracts available'),
            );
          }

          final summary =
          ContractRiskService.buildSummary(contracts);

          final total = summary.totalContracts.toDouble();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= KPI CARDS =================
                Row(
                  children: [
                    _kpiCard(
                        'Contracts',
                        summary.totalContracts.toString(),
                        Icons.description),
                    _kpiCard(
                        'Monthly €',
                        summary.totalMonthlyCost
                            .toStringAsFixed(0),
                        Icons.payments),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _kpiCard(
                        'Yearly €',
                        summary.totalYearlyCost
                            .toStringAsFixed(0),
                        Icons.calendar_today),
                    _kpiCard(
                        'Highest Risk',
                        summary.highestRisk.name.toUpperCase(),
                        Icons.warning,
                        color:
                        _riskColor(summary.highestRisk)),
                  ],
                ),

                const SizedBox(height: 32),

                // ================= PIE CHART =================
                const Text(
                  'Risk Distribution',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 240,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 50,
                      sectionsSpace: 3,
                      sections: [
                        _pieSection(
                          summary.lowRiskCount,
                          total,
                          Colors.green,
                          'Low',
                        ),
                        _pieSection(
                          summary.mediumRiskCount,
                          total,
                          Colors.orange,
                          'Medium',
                        ),
                        _pieSection(
                          summary.highRiskCount,
                          total,
                          Colors.red,
                          'High',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ================= BAR CHART =================
                const Text(
                  'Cost by Risk Level (Yearly)',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      barGroups: _buildRiskCostBars(contracts),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text('Low');
                                case 1:
                                  return const Text('Medium');
                                case 2:
                                  return const Text('High');
                                default:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        rightTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= HELPERS =================

  Widget _kpiCard(
      String title,
      String value,
      IconData icon, {
        Color? color,
      }) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color ?? Colors.blue),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PieChartSectionData _pieSection(
      int count,
      double total,
      Color color,
      String label,
      ) {
    final percentage =
    total == 0 ? 0 : (count / total * 100);

    return PieChartSectionData(
      value: count.toDouble(),
      color: color,
      radius: 55,
      title: count == 0
          ? ''
          : '${percentage.toStringAsFixed(0)}%',
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<BarChartGroupData> _buildRiskCostBars(
      List<ContractEntity> contracts) {
    double low = 0, medium = 0, high = 0;

    for (final c in contracts) {
      final yearly = c.cost * 12;
      switch (c.riskLevel) {
        case RiskLevel.low:
          low += yearly;
          break;
        case RiskLevel.medium:
          medium += yearly;
          break;
        case RiskLevel.high:
          high += yearly;
          break;
      }
    }

    return [
      _bar(0, low, Colors.green),
      _bar(1, medium, Colors.orange),
      _bar(2, high, Colors.red),
    ];
  }

  BarChartGroupData _bar(int x, double value, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 28,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }
}
