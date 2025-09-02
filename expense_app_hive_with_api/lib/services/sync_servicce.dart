import 'package:expense_app_hive_with_api/database/expense_db_hive.dart';
import 'package:expense_app_hive_with_api/services/api_service.dart';

class SyncService {
  static Future<void> syncExpenses() async {
    try {
      final apiExpenses = await ExpenseApi.fetchExpenses();
      await ExpenseDbHive.clearAllExpenses();
      for (var exp in apiExpenses) {
        await ExpenseDbHive.addExpense(exp);
      }
    } catch (e) {
      print("No internet, fallback to local Hive data.");
    }
  }
}