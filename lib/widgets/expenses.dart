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
      showDragHandle: false,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense exp) {
    setState(() {
      _expensesList.add(exp);
    });
  }

  void _addExpenseAtIndex(Expense exp, int index) {
    if (index >= 0 && index <= _expensesList.length + 1) {
      setState(() {
        _expensesList.insert(index, exp);
      });
    }
  }

  void _removeExpense(Expense exp) {
    final int expenseIndex = _expensesList.indexOf(exp);
    setState(() {
      _expensesList.remove(exp);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            _addExpenseAtIndex(exp, expenseIndex);
          },
        ),
        duration: const Duration(seconds: 5),
        persist: false,
        padding: EdgeInsets.all(15),
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.do_not_disturb_alt_sharp,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Text(
                'Deleted Expense: ${exp.title} !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses yet... Try adding some !'),
    );
    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onRemoveExpense: _removeExpense,
      );
    }
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
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
