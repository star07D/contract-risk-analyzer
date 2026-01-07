import '../entities/contract_entity.dart';
import '../entities/risk_summary.dart';

class ContractRiskService {
  static RiskLevel calculateRisk(ContractEntity contract) {
    int score = 0;

    if (contract.isMonthlyCost) score += 1;
    if (contract.minimumDurationMonths >= 12) score += 1;
    if (contract.noticePeriodDays >= 60) score += 1;
    if (contract.cost >= 100) score += 1;

    if (score >= 4) return RiskLevel.high;
    if (score >= 2) return RiskLevel.medium;
    return RiskLevel.low;
  }

  static RiskSummary buildSummary(List<ContractEntity> contracts) {
    double totalMonthly = 0;
    double totalYearly = 0;

    int low = 0;
    int medium = 0;
    int high = 0;

    RiskLevel highest = RiskLevel.low;

    for (final contract in contracts) {
      final risk = calculateRisk(contract);

      switch (risk) {
        case RiskLevel.low:
          low++;
          break;
        case RiskLevel.medium:
          medium++;
          highest = RiskLevel.medium;
          break;
        case RiskLevel.high:
          high++;
          highest = RiskLevel.high;
          break;
      }

      if (contract.isMonthlyCost) {
        totalMonthly += contract.cost;
        totalYearly += contract.cost * 12;
      } else {
        totalYearly += contract.cost;
      }
    }

    return RiskSummary(
      totalMonthlyCost: totalMonthly,
      totalYearlyCost: totalYearly,
      totalContracts: contracts.length,
      lowRiskCount: low,
      mediumRiskCount: medium,
      highRiskCount: high,
      highestRisk: highest,
    );
  }
}
