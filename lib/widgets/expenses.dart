import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
      title: "Credit Card",
      amount: 19.9,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Amsterdam",
      amount: 420,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "BBB cheeseburger",
      amount: 149,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Chart'),
          Expanded(
            child: ExpensesList(expenses: _expensesList),
          ),
        ],
      ),
    );
  }
}
