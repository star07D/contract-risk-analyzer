import '../entities/contract_entity.dart';

enum RiskLevel {
  low,
  medium,
  high,
}

class ContractRiskService {
  /// Calculates risk based on contract conditions
  static RiskLevel calculateRisk(ContractEntity contract) {
    final yearlyCost =
    contract.isMonthlyCost ? contract.cost * 12 : contract.cost;

    int riskScore = 0;

    // Long lock-in increases risk
    if (contract.minimumDurationMonths >= 24) {
      riskScore += 2;
    }

    // Short notice period increases risk
    if (contract.noticePeriodDays <= 30) {
      riskScore += 2;
    }

    // High yearly cost increases risk
    if (yearlyCost >= 400) {
      riskScore += 2;
    }

    if (riskScore >= 4) return RiskLevel.high;
    if (riskScore >= 2) return RiskLevel.medium;
    return RiskLevel.low;
  }

  /// Calculates worst-case cost if user does nothing
  static double calculateWorstCaseCost(
      ContractEntity contract,
      int months,
      ) {
    final monthlyCost =
    contract.isMonthlyCost ? contract.cost : contract.cost / 12;

    return monthlyCost * months;
  }
}
