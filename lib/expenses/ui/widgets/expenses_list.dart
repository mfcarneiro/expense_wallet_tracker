import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    final expenseList = Provider.of<ExpenseModel>(context).expenseList;

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      shrinkWrap: true,
      itemCount: expenseList.length,
      itemBuilder: (context, index) => Dismissible(
        key: UniqueKey(),
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
