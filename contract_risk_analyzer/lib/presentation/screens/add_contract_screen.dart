import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contract_entity.dart';
import '../screens/contracts_provider.dart';
import '../../data/repositories/contract_repository_provider.dart';

class AddContractScreen extends ConsumerStatefulWidget {
  final ContractEntity? existingContract;

  const AddContractScreen({super.key, this.existingContract});

  @override
  ConsumerState<AddContractScreen> createState() =>
      _AddContractScreenState();
}

class _AddContractScreenState
    extends ConsumerState<AddContractScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController costController;
  late TextEditingController minDurationController;
  late TextEditingController noticeController;
  late TextEditingController renewalController;

  ContractCategory category = ContractCategory.other;
  bool isMonthlyCost = true;
  DateTime startDate = DateTime.now();

  bool get isEdit => widget.existingContract != null;

  @override
  void initState() {
    super.initState();

    final c = widget.existingContract;

    nameController =
        TextEditingController(text: c?.name ?? '');
    costController =
        TextEditingController(text: c?.cost.toString() ?? '');
    minDurationController = TextEditingController(
        text: c?.minimumDurationMonths.toString() ?? '');
    noticeController = TextEditingController(
        text: c?.noticePeriodDays.toString() ?? '');
    renewalController = TextEditingController(
        text: c?.renewalCycleMonths.toString() ?? '');

    if (c != null) {
      category = c.category;
      isMonthlyCost = c.isMonthlyCost;
      startDate = c.startDate;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    minDurationController.dispose();
    noticeController.dispose();
    renewalController.dispose();
    super.dispose();
  }

  Future<void> _saveContract() async {
    if (!_formKey.currentState!.validate()) return;

    final repository =
    ref.read(contractRepositoryProvider);

    final contract = ContractEntity(
      id: widget.existingContract?.id,
      name: nameController.text.trim(),
      category: category,
      cost: double.parse(costController.text),
      isMonthlyCost: isMonthlyCost,
      startDate: startDate,
      minimumDurationMonths:
      int.parse(minDurationController.text),
      noticePeriodDays:
      int.parse(noticeController.text),
      renewalCycleMonths:
      int.parse(renewalController.text),
    );

    if (isEdit) {
      await repository.updateContract(contract);
    } else {
      await repository.addContract(contract);
    }

    ref.invalidate(contractsProvider);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Contract' : 'Add Contract'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration:
                const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ContractCategory>(
                value: category,
                items: ContractCategory.values
                    .map(
                      (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name.toUpperCase()),
                  ),
                )
                    .toList(),
                onChanged: (v) =>
                    setState(() => category = v!),
                decoration:
                const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: costController,
                decoration:
                const InputDecoration(labelText: 'Cost'),
                keyboardType:
                const TextInputType.numberWithOptions(
                    decimal: true),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              SwitchListTile(
                title: const Text('Monthly Cost'),
                value: isMonthlyCost,
                onChanged: (v) =>
                    setState(() => isMonthlyCost = v),
              ),
              TextFormField(
                controller: minDurationController,
                decoration: const InputDecoration(
                    labelText: 'Minimum Duration (months)'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: noticeController,
                decoration: const InputDecoration(
                    labelText: 'Notice Period (days)'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: renewalController,
                decoration: const InputDecoration(
                    labelText: 'Renewal Cycle (months)'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveContract,
                child: Text(isEdit ? 'Update' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
