import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenseList;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenseList,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: expenseList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenseList[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenseList[index]);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: const Icon(
            Icons.delete_outlined,
            color: Colors.white70,
            size: 30,
          ),
        ),
        direction: DismissDirection.endToStart,
        child: ExpenseItem(
          expenseList[index],
        ),
      ),
    );
  }
}
