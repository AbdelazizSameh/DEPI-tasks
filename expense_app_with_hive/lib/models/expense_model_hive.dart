class ExpenseModelHive {
  final int? id;
  final DateTime date;
  final double amount;
  final String category;
  final String note;

  ExpenseModelHive({
    this.id,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
  });

  factory ExpenseModelHive.fromMap(Map<String, dynamic> map) {
    return ExpenseModelHive(
      id: map['id'],
      date: DateTime.parse(map['date']),
      amount: (map['amount'] as num).toDouble(),
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
