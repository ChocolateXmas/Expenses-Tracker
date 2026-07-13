import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Expense {
  Expense({required this.title, required this.amount, required this.date})
    : id = uuid.v5(Namespace.nil.value, title);

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
