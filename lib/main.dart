import 'package:flutter/material.dart';
import 'package:expenses_tracker/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Expenses(),
        ),
      ),
    ),
  );
}
