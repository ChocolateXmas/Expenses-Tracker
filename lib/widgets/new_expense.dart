import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense exp) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Widget _modalDragTitle(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The Drag Handle itself
                Container(
                  width: 35,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12), // Gap between handle and title
                // The Anchored Title
                Text(
                  'New Expense',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  void _submitExpenseData() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);
    final isAmountInvalid = amount == null || amount <= 0;
    if (title.isEmpty || isAmountInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            textAlign: TextAlign.center,
            'Invalid data input',
          ),
          content: Text(
            textAlign: TextAlign.center,
            'Make sure to fill Title, Amount & select Date',
          ),
          actions: [
            Center(
              child: TextButton.icon(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(ctx);
                },
                label: Text('Close'),
              ),
            ),
          ],
        ),
      );
      return;
    }
    /*
      Add a new expense through the onAddExpense Pointer
      directly to the Expenses Screen
    */
    widget.onAddExpense(
      Expense(
        title: title,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // TextField - Expense Title
    final TextField expenseTitleTxtF = TextField(
      controller: _titleController,
      maxLength: 35,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
    // TextField - Expense Amount
    final TextField expenseAmountTxtF = TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$ ',
        label: Text('Amount'),
      ),
    );
    // Category Selector
    final DropdownButton categorySelector = DropdownButton(
      value: _selectedCategory,
      hint: Text('Category'),
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _selectedCategory = value;
        });
      },
    );
    // Date Picker
    final Row expenseDatePicker = Row(
      mainAxisAlignment: MainAxisAlignment.end, // align Icon + Text to the end
      crossAxisAlignment:
          CrossAxisAlignment.center, // center aligned  ONLY text
      children: [
        Text(
          _selectedDate != null
              ? formatter.format(_selectedDate!)
              : 'No Selected Date',
        ),
        IconButton(
          onPressed: _showDatePicker,
          icon: Icon(Icons.date_range),
        ),
      ],
    );
    // Save Button
    final ElevatedButton expenseSaveButton = ElevatedButton(
      onPressed: () => _submitExpenseData(),
      child: const Text('Save'),
    );
    // Cancel Button
    final TextButton expenseCancelButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Cancel'),
    );
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final maxWidth = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _modalDragTitle(context),
                Padding(
                  padding: EdgeInsets.only(
                    left: 35,
                    right: 35,
                    top: 10,
                    bottom: keyboardHeight + 35,
                  ),
                  child: Column(
                    children: [
                      // Landscape Mode
                      if (maxWidth >= 600)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TextField - Expense Title
                            Expanded(child: expenseTitleTxtF),
                            const SizedBox(width: 24),
                            // TextField - Expense Amount
                            Expanded(child: expenseAmountTxtF),
                          ],
                        )
                      // Portrait Mode
                      else
                        // TextField - Expense Title
                        expenseTitleTxtF,
                      // Landscape Mode
                      if (maxWidth >= 600)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Category Selector
                            categorySelector,
                            const SizedBox(width: 15),
                            // Date Picker
                            Expanded(child: expenseDatePicker),
                          ],
                        )
                      // Portrait Mode
                      else
                        Row(
                          children: [
                            // TextField - Expense Amount
                            Expanded(child: expenseAmountTxtF),
                            const SizedBox(width: 15),
                            // Date Picker
                            Expanded(child: expenseDatePicker),
                          ],
                        ),
                      // Landscape Mode
                      if (maxWidth >= 600)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Save Button
                            expenseSaveButton,
                            // Cancel Button
                            expenseCancelButton,
                          ],
                        )
                      // Portrait Mode
                      else
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Category Selector
                              categorySelector,
                              // Save Button
                              expenseSaveButton,
                              // Cancel Button
                              expenseCancelButton,
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
