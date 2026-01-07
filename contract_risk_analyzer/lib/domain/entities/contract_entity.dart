import 'package:contract_risk_analyzer/domain/entities/risk_summary.dart';
import 'package:equatable/equatable.dart';

import '../services/contract_risk_service.dart';

enum ContractCategory {
  streaming,
  travelpass,
  utilities,
  insurance,
  software,
  finance,
  other,
}

class ContractEntity extends Equatable {
  final int? id;
  final String name;
  final ContractCategory category;
  final double cost;
  final bool isMonthlyCost;
  final DateTime startDate;
  final int minimumDurationMonths;
  final int noticePeriodDays;
  final int renewalCycleMonths;
  final RiskLevel riskLevel;

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
    required this.riskLevel,
  });

  ContractEntity copyWith({
    int? id,
    String? name,
    ContractCategory? category,
    double? cost,
    bool? isMonthlyCost,
    DateTime? startDate,
    int? minimumDurationMonths,
    int? noticePeriodDays,
    int? renewalCycleMonths,
    RiskLevel? riskLevel,
  }) {
    return ContractEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      cost: cost ?? this.cost,
      isMonthlyCost: isMonthlyCost ?? this.isMonthlyCost,
      startDate: startDate ?? this.startDate,
      minimumDurationMonths:
      minimumDurationMonths ?? this.minimumDurationMonths,
      noticePeriodDays: noticePeriodDays ?? this.noticePeriodDays,
      renewalCycleMonths:
      renewalCycleMonths ?? this.renewalCycleMonths,
      riskLevel: riskLevel ?? this.riskLevel,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    cost,
    isMonthlyCost,
    startDate,
    minimumDurationMonths,
    noticePeriodDays,
    renewalCycleMonths,
    riskLevel,
  ];
}
