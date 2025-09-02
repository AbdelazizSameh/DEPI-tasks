import 'package:expense_app_hive_with_api/model/hive_model.dart';
import 'package:hive/hive.dart';

class ExpenseModelHiveAdapter extends TypeAdapter<ExpenseModelHive> {
  @override
  final int typeId = 0;

  @override
  ExpenseModelHive read(BinaryReader reader) {
    return ExpenseModelHive(
      date: reader.read() as DateTime,
      amount: reader.read() as double,
      category: reader.read() as String,
      note: reader.read() as String,
      apiId: reader.read() as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModelHive obj) {
    writer.write(obj.date);
    writer.write(obj.amount);
    writer.write(obj.category);
    writer.write(obj.note);
    writer.write(obj.apiId);
  }
}
