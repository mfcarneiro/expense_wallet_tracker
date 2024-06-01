import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: <Widget>[
            Text(expense.title),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('R\$ ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      categoryIcons[expense.categoryItem],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(expense.date),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime currentDate) {
    return DateFormat.yMMMd().format(currentDate);
  }
}
