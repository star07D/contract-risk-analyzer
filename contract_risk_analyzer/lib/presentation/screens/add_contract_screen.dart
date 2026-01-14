import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/contract_repository_provider.dart';
import '../../domain/entities/contract_entity.dart';
import '../../domain/entities/risk_summary.dart';
import '../../domain/services/contract_risk_service.dart';

import '../providers/contracts_provider.dart';
import '../providers/notification_scheduler_provider.dart';
import '../providers/contracts_provider.dart';


class AddContractScreen extends ConsumerStatefulWidget {
  final ContractEntity? existingContract;

  const AddContractScreen({super.key, this.existingContract});

  @override
  ConsumerState<AddContractScreen> createState() =>
      _AddContractScreenState();
}

class _AddContractScreenState extends ConsumerState<AddContractScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _costController;
  late final TextEditingController _minDurationController;
  late final TextEditingController _noticeController;
  late final TextEditingController _renewalController;

  late ContractCategory _category;
  late bool _isMonthly;

  @override
  void initState() {
    super.initState();

    final c = widget.existingContract;

    _nameController = TextEditingController(text: c?.name ?? '');
    _costController =
        TextEditingController(text: c?.cost.toString() ?? '');
    _minDurationController = TextEditingController(
        text: c?.minimumDurationMonths.toString() ?? '1');
    _noticeController = TextEditingController(
        text: c?.noticePeriodDays.toString() ?? '30');
    _renewalController = TextEditingController(
        text: c?.renewalCycleMonths.toString() ?? '12');

    _category = c?.category ?? ContractCategory.other;
    _isMonthly = c?.isMonthlyCost ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _minDurationController.dispose();
    _noticeController.dispose();
    _renewalController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final repository = ref.read(contractRepositoryProvider);
    final scheduler = ref.read(contractNotificationSchedulerProvider);

    //STEP 1 — build contract WITHOUT risk
    final tempContract = ContractEntity(
      id: widget.existingContract?.id,
      name: _nameController.text.trim(),
      category: _category,
      cost: double.parse(_costController.text),
      isMonthlyCost: _isMonthly,
      startDate:
      widget.existingContract?.startDate ?? DateTime.now(),
      minimumDurationMonths:
      int.parse(_minDurationController.text),
      noticePeriodDays: int.parse(_noticeController.text),
      renewalCycleMonths: int.parse(_renewalController.text),
      riskLevel: RiskLevel.low, // placeholder
    );

    //STEP 2 — calculate risk (DOMAIN)
    final finalContract = tempContract.copyWith(
      riskLevel:
      ContractRiskService.calculateRisk(tempContract),
    );

    //STEP 3 — persist (FAST)
    if (widget.existingContract == null) {
      await repository.addContract(finalContract);
    } else {
      await repository.updateContract(finalContract);
    }

    //FORCE LIST REFRESH (CRITICAL FIX)
    ref.invalidate(contractsProvider);

    //STEP 5 — close screen immediately
    if (mounted) {
      Navigator.pop(context);
    }

    //STEP 6 — reschedule notifications (non-blocking)
    Future.microtask(() async {
      final contracts = await repository.getAllContracts();
      await scheduler.scheduleForContracts(contracts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingContract == null
              ? 'Add Contract'
              : 'Edit Contract',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _costController,
                decoration:
                const InputDecoration(labelText: 'Cost'),
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<ContractCategory>(
                value: _category,
                decoration:
                const InputDecoration(labelText: 'Category'),
                items: ContractCategory.values
                    .map(
                      (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c.name),
                  ),
                )
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              SwitchListTile(
                title: const Text('Monthly Cost'),
                value: _isMonthly,
                onChanged: (v) =>
                    setState(() => _isMonthly = v),
              ),
              TextFormField(
                controller: _minDurationController,
                decoration: const InputDecoration(
                    labelText: 'Minimum Duration (months)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _noticeController,
                decoration: const InputDecoration(
                    labelText: 'Notice Period (days)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _renewalController,
                decoration: const InputDecoration(
                    labelText: 'Renewal Cycle (months)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
