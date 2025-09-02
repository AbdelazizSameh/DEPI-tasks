import 'package:expense_app_hive_with_api/database/expense_db_hive.dart';
import 'package:expense_app_hive_with_api/model/hive_model.dart';
import 'package:expense_app_hive_with_api/services/api_service.dart';
import 'package:expense_app_hive_with_api/view/add_edit_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ExpenseModelHive> _expenses = [];
  Map<int, ExpenseModelHive> _expensesWithKeys = {};

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() {
    _expensesWithKeys = ExpenseDbHive.getAllExpensesWithKeys();
    _expenses = _expensesWithKeys.values.toList();
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    setState(() {});
  }

  Future<void> _addOrEditExpense({
    ExpenseModelHive? expense,
    int? index,
  }) async {
    int? hiveKey;
    if (index != null) {
      hiveKey = _expensesWithKeys.keys.elementAt(index);
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditView(expense: expense, hiveKey: hiveKey),
      ),
    );

    if (result != null) {
      _loadExpenses();
    }
  }

  Future<void> _deleteExpense(int index) async {
    final key = _expensesWithKeys.keys.elementAt(index);
    final expense = _expensesWithKeys.values.elementAt(index);

    await ExpenseApi.deleteExpense(expense);

    await ExpenseDbHive.deleteExpense(key);

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
                    onTap: () =>
                        _addOrEditExpense(expense: expense, index: index),
                    leading: CircleAvatar(
                      child: Text("\$${expense.amount.toStringAsFixed(0)}"),
                    ),
                    title: Text(expense.category),
                    subtitle: Text(
                      "${expense.note} - ${expense.date.toString().split(' ')[0]}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _addOrEditExpense(expense: expense, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteExpense(index),
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
