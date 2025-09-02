import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ExpenseModelHive extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String category;

  @HiveField(3)
  late String note;

  @HiveField(4)
  String? apiId; 
  ExpenseModelHive({
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
    this.apiId
  });
}
