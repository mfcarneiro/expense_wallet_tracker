import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();

  var _expenseTitle = '';
  var _expenseAmount = 0.0;
  var _selectedDate = DateTime.now();
  var _selectedCategory = CategoryItem.groceries;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: _expenseTitle,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title cannot be empty';
                }
                return null;
              },
              onChanged: (value) {
                _expenseTitle = value;
              },
              onSaved: (value) {
                _expenseTitle = value!;
              },
              textInputAction: TextInputAction.next,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Expense title'),
                border: OutlineInputBorder(),
                icon: Icon(Icons.edit_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Amount cannot be empty';
                }
                return null;
              },
              onChanged: (value) {
                _expenseAmount = double.parse(value);
              },
              onSaved: (value) {
                _expenseAmount = double.parse(value!);
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                prefixText: 'R\$ ',
                icon: Icon(Icons.attach_money_outlined),
                label: Text('Amount'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _currentDateFormat(_selectedDate),
              onTap: _presentDateTimePicker,
              readOnly: true,
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month_outlined),
                label: Text('Date'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedCategory,
              items: CategoryItem.values.map(
                (category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(
                      _formatCategoryListItems(category.name),
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.sell_outlined),
              ),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onSubmitNewExpense,
                    child: const Text('Register expense'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String _currentDateFormat(DateTime selectedDate) {
    return DateFormat.yMMMMd().format(selectedDate).toString();
  }

  String _formatCategoryListItems(String categoryName) {
    return categoryName[0].toUpperCase() + categoryName.substring(1);
  }

  void _onSubmitNewExpense() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Provider.of<ExpenseModel>(
        context,
        listen: false,
      ).addNewExpense(
        title: _expenseTitle,
        amount: _expenseAmount,
        date: _selectedDate,
        category: _selectedCategory,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New $_expenseTitle was added!'),
        ),
      );

      Navigator.pop(context);
    }
  }

  void _presentDateTimePicker() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );

    setState(() {
      if (pickedDate != null) {
        _selectedDate = pickedDate;
      }
    });
  }
}
