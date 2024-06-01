import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';

class CalculateTotalAmount {
  double execute(List<Expense> expenseList, CategoryItem category) {
    double result = 0.0;

    for (final expense in expenseList) {
      result += expense.amount;
    }

    return result;
  }
}
