import 'package:uuid/uuid.dart';

enum ContractCategory {
  internet,
  mobile,
  insurance,
  travelling,
  gym,
  streaming,
  software,
  other,
}

class ContractEntity {
  final int? id; // ✅ int, nullable for inserts
  final String name;
  final ContractCategory category;
  final double cost;
  final bool isMonthlyCost;
  final DateTime startDate;
  final int minimumDurationMonths;
  final int noticePeriodDays;
  final int renewalCycleMonths;

  const ContractEntity({
    this.id,
    required this.name,
    required this.category,
    required this.cost,
    required this.isMonthlyCost,
    required this.startDate,
    required this.minimumDurationMonths,
    required this.noticePeriodDays,
    required this.renewalCycleMonths,
  });
}
