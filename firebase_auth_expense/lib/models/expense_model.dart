// class ExpenseModel {
//   final int? id;
//   final DateTime date;
//   final double amount;
//   final String category;
//   final String note;

//   ExpenseModel({
//     this.id,
//     required this.date,
//     required this.amount,
//     required this.category,
//     required this.note,
//   });

//   factory ExpenseModel.fromMap(Map<String, dynamic> map) {
//     return ExpenseModel(
//       id: map['id'],
//       date: DateTime.parse(map['date']),
//       amount: map['amount'],
//       category: map['category'],
//       note: map['note'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date.toIso8601String(),
//       'amount': amount,
//       'category': category,
//       'note': note,
//     };
//   }
// }
class Journal {
  final String id;
  final String note;
  final String mood;
  final String date;

  Journal({
    required this.id,
    required this.note,
    required this.mood,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'note': note, 'mood': mood, 'date': date};
  }

  factory Journal.fromMap(Map<String, dynamic> map, String id) {
    return Journal(
      id: id,
      note: map['note'] ?? '',
      mood: map['mood'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
