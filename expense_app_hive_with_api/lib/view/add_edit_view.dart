import 'package:expense_app_hive_with_api/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:expense_app_hive_with_api/database/expense_db_hive.dart';
import 'package:expense_app_hive_with_api/model/hive_model.dart';

class AddEditView extends StatefulWidget {
  final ExpenseModelHive? expense;
  final int? hiveKey;

  const AddEditView({super.key, this.expense, this.hiveKey});

  @override
  State<AddEditView> createState() => _AddEditViewState();
}

class _AddEditViewState extends State<AddEditView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late TextEditingController _noteController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.expense?.amount.toString() ?? "",
    );
    _categoryController = TextEditingController(
      text: widget.expense?.category ?? "",
    );
    _noteController = TextEditingController(text: widget.expense?.note ?? "");
    _selectedDate = widget.expense?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveExpense() async {
    if (_formKey.currentState!.validate()) {
      final newExpense = ExpenseModelHive(
        date: _selectedDate,
        amount: double.parse(_amountController.text),
        category: _categoryController.text,
        note: _noteController.text,
        apiId: widget.expense?.apiId,
      );

      if (widget.hiveKey == null) {
        final apiExpense = await ExpenseApi.addExpense(newExpense);
        if (apiExpense != null) {
          await ExpenseDbHive.addExpense(apiExpense);
        }
      } else {
        await ExpenseApi.updateExpense(newExpense);
        await ExpenseDbHive.updateExpense(widget.hiveKey!, newExpense);
      }

      Navigator.pop(context, newExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hiveKey == null ? "Add Expense" : "Edit Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter amount" : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: "Category"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter category" : null,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: "Note"),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveExpense,
                child: Text(widget.hiveKey == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
