import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryItem categoryItem;

  factory Expense.newExpense({
    required String title,
    required double amount,
    required DateTime date,
    required CategoryItem categoryItem,
  }) {
    const uuid = Uuid();

    return Expense._(
      id: uuid.v4(),
      title: title,
      amount: amount,
      date: date,
      categoryItem: categoryItem,
    );
  }

  const Expense._({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryItem,
  });
}
