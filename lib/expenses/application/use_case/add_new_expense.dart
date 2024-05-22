import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';

class AddNewExpense {
  Expense execute({
    required String title,
    required double amount,
    required DateTime date,
    required CategoryItem categoryItem,
  }) {
    return Expense.newExpense(
      title: title,
      amount: amount,
      date: date,
      categoryItem: categoryItem,
    );
  }
}
