import 'package:firebase_auth_expense/models/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/hive_adapter.dart';

class ExpenseDbHive {
  static const String boxName = 'expensesBox';
  static late Box<ExpenseModelHive> _box;

  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseModelHiveAdapter());
    _box = await Hive.openBox<ExpenseModelHive>(boxName);
  }

  static Future<void> addExpense(ExpenseModelHive model) async {
    await _box.add(model);
  }

  static List<ExpenseModelHive> getAllExpenses() {
    final expenses = _box.values.toList();
    expenses.sort((a, b) => b.date.compareTo(a.date));
    return expenses;
  }

  static Future<void> updateExpense(int key, ExpenseModelHive model) async {
    await _box.put(key, model);
  }

  static Future<void> deleteExpense(int key) async {
    await _box.delete(key);
  }

  static Future<void> clearAllExpenses() async {
    await _box.clear();
  }

  static Map<int, ExpenseModelHive> getAllExpensesWithKeys() {
    return _box.toMap().map((key, value) => MapEntry(key as int, value));
  }
}
