import 'package:expense_app_with_sqflite/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "expenses.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE expenses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            category TEXT,
            note TEXT,
            date TEXT
          )
        """);
      },
    );
  }

  static Future<int> insertExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.insert("expenses", expense.toMap());
  }

  static Future<List<ExpenseModel>> getExpenses() async {
    final db = await database;
    final maps = await db.query("expenses", orderBy: "date DESC");
    return maps.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  static Future<int> updateExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.update(
      "expenses",
      expense.toMap(),
      where: "id = ?",
      whereArgs: [expense.id],
    );
  }

  static Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete("expenses", where: "id = ?", whereArgs: [id]);
  }
}
