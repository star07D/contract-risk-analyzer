import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contract_entity.dart';
import '../../data/repositories/contract_repository_provider.dart';
import 'contracts_provider.dart';

class AddContractScreen extends ConsumerStatefulWidget {
  const AddContractScreen({super.key});

  @override
  ConsumerState<AddContractScreen> createState() =>
      _AddContractScreenState();
}

class _AddContractScreenState extends ConsumerState<AddContractScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _costController = TextEditingController();

  ContractCategory _category = ContractCategory.internet;
  bool _isMonthly = true;

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  Future<void> _saveContract() async {
    if (!_formKey.currentState!.validate()) return;

    final repository = ref.read(contractRepositoryProvider);

    final contract = ContractEntity(
      name: _nameController.text.trim(),
      category: _category,
      cost: double.parse(_costController.text),
      isMonthlyCost: _isMonthly,
      startDate: DateTime.now(),
      minimumDurationMonths: 12,
      noticePeriodDays: 30,
      renewalCycleMonths: 12,
    );

    await repository.addContract(contract);

    ref.invalidate(contractsProvider); // 🔥 auto refresh list

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Contract')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Contract Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || double.tryParse(value) == null
                    ? 'Enter valid number'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ContractCategory>(
                value: _category,
                items: ContractCategory.values
                    .map(
                      (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c.name),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _category = value);
                },
                decoration:
                const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Monthly Cost'),
                value: _isMonthly,
                onChanged: (value) {
                  setState(() => _isMonthly = value);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveContract,
                child: const Text('Save Contract'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
