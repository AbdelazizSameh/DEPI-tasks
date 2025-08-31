import 'dart:convert';
import 'package:expense_app_with_hive/models/expense_model_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDb {
  static const String boxName = "ExpensesDB";
  static late final Box _box;

  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Map<int, ExpenseModelHive> getAllExpensesWithKeys() {
    final Map<int, ExpenseModelHive> expenses = {};
    for (var key in _box.keys) {
      final map = jsonDecode(_box.get(key));
      expenses[key] = ExpenseModelHive.fromMap(map);
    }
    return expenses;
  }

  static Future<void> addExpense(ExpenseModelHive expense) async {
    final map = expense.toMap();
    await _box.add(jsonEncode(map));
  }

  static Future<void> updateExpense(int key, ExpenseModelHive expense) async {
    final map = expense.toMap();
    await _box.put(key, jsonEncode(map));
  }

  static Future<void> deleteExpense(int key) async {
    await _box.delete(key);
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }
}
