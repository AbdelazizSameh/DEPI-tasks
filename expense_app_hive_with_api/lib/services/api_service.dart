import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expense_app_hive_with_api/model/hive_model.dart';

class ExpenseApi {
  static const String baseUrl =
      "https://68b302b3c28940c9e69dedf9.mockapi.io/products/v1/expenses";

  static Future<List<ExpenseModelHive>> fetchExpenses() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) {
        return ExpenseModelHive(
          apiId: json['id'],
          date: DateTime.parse(json['date']),
          amount: double.parse(json['amount'].toString()),
          category: json['category'],
          note: json['note'],
        );
      }).toList();
    } else {
      throw Exception("Failed to load expenses from API");
    }
  }

  static Future<ExpenseModelHive?> addExpense(ExpenseModelHive expense) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "date": expense.date.toIso8601String(),
        "amount": expense.amount,
        "category": expense.category,
        "note": expense.note,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return ExpenseModelHive(
        apiId: data['id'],
        date: DateTime.parse(data['date']),
        amount: double.parse(data['amount'].toString()),
        category: data['category'],
        note: data['note'],
      );
    }
    return null;
  }

  static Future<void> updateExpense(ExpenseModelHive expense) async {
    if (expense.apiId == null) return;
    await http.put(
      Uri.parse("$baseUrl/${expense.apiId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "date": expense.date.toIso8601String(),
        "amount": expense.amount,
        "category": expense.category,
        "note": expense.note,
      }),
    );
  }

  static Future<void> deleteExpense(ExpenseModelHive expense) async {
    if (expense.apiId == null) return;
    await http.delete(Uri.parse("$baseUrl/${expense.apiId}"));
  }
}
