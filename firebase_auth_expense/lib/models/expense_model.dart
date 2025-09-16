class ExpenseModel {
  final int? id; 
  final DateTime date;
  final double amount;
  final String category;
  final String note;

  ExpenseModel({
    this.id,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
  });

  
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
      category: map['category'],
      note: map['note'],
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'category': category,
      'note': note,
    };
  }
}
