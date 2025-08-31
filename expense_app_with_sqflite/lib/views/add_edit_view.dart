import 'package:expense_app_with_sqflite/database/db_helper.dart';
import 'package:expense_app_with_sqflite/models/expense_model.dart';
import 'package:flutter/material.dart';

class AddEditView extends StatefulWidget {
  final ExpenseModel? expense;

  const AddEditView({super.key, this.expense});

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
    if (widget.expense != null) {
      _selectedDate = DateTime.parse(widget.expense!.date);
    }
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

  Future<void> _saveExpense() async {
    if (_formKey.currentState!.validate()) {
      final expense = ExpenseModel(
        id: widget.expense?.id,
        amount: double.parse(_amountController.text),
        category: _categoryController.text,
        note: _noteController.text,
        date: _selectedDate.toIso8601String().split("T")[0],
      );

      if (widget.expense == null) {
        await DBHelper.insertExpense(expense);
      } else {
        await DBHelper.updateExpense(expense);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? "Add Expense" : "Edit Expense"),
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
                child: Text(widget.expense == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
