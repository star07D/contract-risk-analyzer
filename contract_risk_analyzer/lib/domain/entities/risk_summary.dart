import 'contract_entity.dart';

enum RiskLevel {
  low,
  medium,
  high,
}

class RiskSummary {
  final double totalMonthlyCost;
  final double totalYearlyCost;

  final int totalContracts;
  final int lowRiskCount;
  final int mediumRiskCount;
  final int highRiskCount;

  final RiskLevel highestRisk;

  const RiskSummary({
    required this.totalMonthlyCost,
    required this.totalYearlyCost,
    required this.totalContracts,
    required this.lowRiskCount,
    required this.mediumRiskCount,
    required this.highRiskCount,
    required this.highestRisk,
  });
}
