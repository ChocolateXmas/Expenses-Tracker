import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var uuid = Uuid();
var formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const Map<Enum, IconData> categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

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

  String get formattedDate {
    return formatter.format(date);
  }
}
