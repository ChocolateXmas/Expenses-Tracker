import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35),
      child: Column(
        children: [
          TextField(
            maxLength: 35,
            decoration: InputDecoration(
              label: Text('Expense Name'),
            ),
          ),
          Row(),
          Row(),
        ],
      ),
    );
  }
}
