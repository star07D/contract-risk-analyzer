import '../entities/contract_entity.dart';
import '../entities/risk_summary.dart';

class ContractNotificationPolicy {
  /// Returns all notification dates for a contract (can be empty)
  static List<DateTime> notificationDates(ContractEntity contract) {
    if (contract.riskLevel == RiskLevel.low) {
      return [];
    }

    final renewalDate = _nextRenewalDate(contract);
    if (renewalDate == null) return [];

    final now = DateTime.now();
    final List<int> offsets;

    switch (contract.riskLevel) {
      case RiskLevel.high:
        offsets = [30, 7, 1];
        break;
      case RiskLevel.medium:
        offsets = [7, 1];
        break;
      case RiskLevel.low:
        offsets = [];
        break;
    }

    return offsets
        .map((days) => renewalDate.subtract(Duration(days: days)))
        .where((date) => date.isAfter(now))
        .toList();
  }

  static DateTime? _nextRenewalDate(ContractEntity contract) {
    final start = contract.startDate;
    final cycle = contract.renewalCycleMonths;

    if (cycle <= 0) return null;

    DateTime renewal = start;

    while (renewal.isBefore(DateTime.now())) {
      renewal = DateTime(
        renewal.year,
        renewal.month + cycle,
        renewal.day,
      );
    }

    return renewal;
  }
}
