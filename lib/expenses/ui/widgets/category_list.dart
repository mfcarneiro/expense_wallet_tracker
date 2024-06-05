import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/category_list_item.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseModel>(context);

    void onRemoveExpense(Expense expense) {
      final expenseIndex = context.read<ExpenseModel>().removeExpense(expense);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${expense.title} was removed',
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              context
                  .read<ExpenseModel>()
                  .undoRemoveExpense(expense, expenseIndex);
            },
          ),
        ),
      );
    }

    Widget buildEmptyExpenseMessage(BuildContext context) {
      return Center(
        child: Text(
          'You are rocking! No expenses here!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return provider.expenseList.isEmpty
        ? buildEmptyExpenseMessage(context)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: provider.isCategoryFilterVisible,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8.0,
                    children: List<Widget>.generate(
                      provider.categoryList.length,
                      (index) {
                        return CategoryListItem(
                          category: provider.categoryList.toList()[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ExpensesList(
                  onRemoveExpense: onRemoveExpense,
                ),
              ),
            ],
          );
  }
}
