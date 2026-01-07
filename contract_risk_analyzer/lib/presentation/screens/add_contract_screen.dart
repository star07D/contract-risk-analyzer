import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/services/contract_risk_service.dart';
import '../../data/repositories/contract_repository_provider.dart';

class AddContractScreen extends ConsumerStatefulWidget {
  final ContractEntity? existingContract;

  const AddContractScreen({super.key, this.existingContract});

  @override
  ConsumerState<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState extends ConsumerState<AddContractScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final costController = TextEditingController();
  final minDurationController = TextEditingController();
  final noticeController = TextEditingController();
  final renewalController = TextEditingController();

  ContractCategory category = ContractCategory.other;
  bool isMonthlyCost = false;
  DateTime startDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    final c = widget.existingContract;
    if (c != null) {
      nameController.text = c.name;
      costController.text = c.cost.toString();
      minDurationController.text = c.minimumDurationMonths.toString();
      noticeController.text = c.noticePeriodDays.toString();
      renewalController.text = c.renewalCycleMonths.toString();
      category = c.category;
      isMonthlyCost = c.isMonthlyCost;
      startDate = c.startDate;
    }
  }

  Future<void> _saveContract() async {
    if (!_formKey.currentState!.validate()) return;

    final repository = ref.read(contractRepositoryProvider);

    /// STEP 1 — create a temporary contract
    final tempContract = ContractEntity(
      id: widget.existingContract?.id,
      name: nameController.text.trim(),
      category: category,
      cost: double.parse(costController.text),
      isMonthlyCost: isMonthlyCost,
      startDate: startDate,
      minimumDurationMonths: int.parse(minDurationController.text),
      noticePeriodDays: int.parse(noticeController.text),
      renewalCycleMonths: int.parse(renewalController.text),
      riskLevel: RiskLevel.low, // placeholder
    );

    /// STEP 2 — calculate real risk
    final contract = tempContract.copyWith(
      riskLevel: ContractRiskService.calculateRisk(tempContract),
    );

    if (widget.existingContract == null) {
      await repository.addContract(contract);
    } else {
      await repository.updateContract(contract);
    }

    ref.invalidate(contractRepositoryProvider);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingContract == null
            ? 'Add Contract'
            : 'Edit Contract'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: costController,
                decoration: const InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<ContractCategory>(
                value: category,
                items: ContractCategory.values
                    .map(
                      (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                    .toList(),
                onChanged: (v) => setState(() => category = v!),
                decoration:
                const InputDecoration(labelText: 'Category'),
              ),
              SwitchListTile(
                title: const Text('Monthly Cost'),
                value: isMonthlyCost,
                onChanged: (v) => setState(() => isMonthlyCost = v),
              ),
              TextFormField(
                controller: minDurationController,
                decoration: const InputDecoration(
                    labelText: 'Minimum Duration (months)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: noticeController,
                decoration: const InputDecoration(
                    labelText: 'Notice Period (days)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: renewalController,
                decoration: const InputDecoration(
                    labelText: 'Renewal Cycle (months)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveContract,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
