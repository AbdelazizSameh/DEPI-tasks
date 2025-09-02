import 'package:expense_app_hive_with_api/database/expense_db_hive.dart';
import 'package:expense_app_hive_with_api/services/sync_servicce.dart';
import 'package:expense_app_hive_with_api/view/home_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExpenseDbHive.initDatabase();
  await SyncService.syncExpenses();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
