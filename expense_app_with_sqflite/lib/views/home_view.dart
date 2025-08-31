import 'package:expense_app_with_sqflite/database/db_helper.dart';
import 'package:expense_app_with_sqflite/models/expense_model.dart';
import 'package:expense_app_with_sqflite/views/add_edit_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ExpenseModel> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final data = await DBHelper.getExpenses();
    setState(() {
      _expenses = data;
    });
  }

  Future<void> _addOrEditExpense({ExpenseModel? expense}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditView(expense: expense)),
    );

    if (result == true) {
      _loadExpenses();
    }
  }

  Future<void> _deleteExpense(int id) async {
    await DBHelper.deleteExpense(id);
    _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      body: _expenses.isEmpty
          ? const Center(child: Text("No expenses yet."))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () => _addOrEditExpense(expense: expense),
                    leading: CircleAvatar(
                      child: Text("\$${expense.amount.toStringAsFixed(0)}"),
                    ),
                    title: Text(expense.category),
                    subtitle: Text("${expense.note} - ${expense.date}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _addOrEditExpense(expense: expense),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteExpense(expense.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditExpense(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
