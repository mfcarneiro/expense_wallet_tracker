import 'package:expenses_wallet_tracker/expenses/application/use_case/add_new_expense.dart';
import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:flutter/material.dart';

class ExpenseModel with ChangeNotifier {
  final List<Expense> _expenseList = [];

  List<Expense> get expenseList => _expenseList;

  void addNewExpense({
    required String title,
    required double amount,
    required DateTime date,
    required CategoryItem category,
  }) {
    final newExpense = AddNewExpense().execute(
      title: title,
      amount: amount,
      date: date,
      categoryItem: category,
    );

    _expenseList.add(newExpense);

    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _expenseList.remove(expense);

    notifyListeners();
  }

  void undoRemoveExpense(Expense expense, int index) {
    _expenseList.insert(index, expense);

    notifyListeners();
  }
}
