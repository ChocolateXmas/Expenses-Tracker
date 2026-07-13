import 'package:uuid/uuid.dart';

var uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v5(Namespace.nil.value, title);

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
