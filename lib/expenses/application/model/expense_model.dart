import 'package:expenses_wallet_tracker/expenses/application/use_case/add_new_expense.dart';
import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseModel with ChangeNotifier implements ReassembleHandler {
  final List<Expense> _mainExpenseList = [];
  final Set<CategoryItem> _categoryList = {};

  List<Expense> _expenseList = [];
  int? isCategorySelected;
  bool isCategoryFilterVisible = true;
  int categoryFilterCounter = 0;

  Set<CategoryItem> get categoryList => _categoryList;
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

    _mainExpenseList.add(newExpense);
    _expenseList.add(newExpense);
    _categoryList.add(newExpense.categoryItem);
    categoryFilterCounter++;

    notifyListeners();
  }

  @override
  void reassemble() {}

  int removeExpense(Expense expense) {
    final expenseIndex = _mainExpenseList.indexOf(expense);

    _mainExpenseList.remove(expense);
    _expenseList.remove(expense);
    _categoryList.remove(expense.categoryItem);

    categoryFilterCounter--;

    notifyListeners();

    return expenseIndex;
  }

  void toggleCategoryFilterVisible() {
    isCategoryFilterVisible = !isCategoryFilterVisible;

    notifyListeners();
  }

  void toggleFilterByCategory(CategoryItem categoryItem) {
    if (isCategorySelected == null) {
      _expenseList = _mainExpenseList.toList();

      notifyListeners();

      return;
    }

    _expenseList = _mainExpenseList
        .where((filter) => filter.categoryItem == categoryItem)
        .toList();

    notifyListeners();
  }

  void undoRemoveExpense(Expense expense, int index) {
    _mainExpenseList.insert(index, expense);
    _expenseList.insert(index, expense);
    _categoryList.add(expense.categoryItem);
    categoryFilterCounter++;

    notifyListeners();
  }
}
