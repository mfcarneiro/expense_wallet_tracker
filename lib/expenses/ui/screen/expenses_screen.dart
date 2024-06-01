import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/category_list.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCategoryFilterVisible =
        Provider.of<ExpenseModel>(context).isCategoryFilterVisible;
    int categoryFilterCounter =
        Provider.of<ExpenseModel>(context).categoryFilterCounter;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ExpenseModel>().toggleCategoryFilterVisible();
            },
            selectedIcon: Badge.count(
              count: categoryFilterCounter,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.filter_list,
                fill: 1.0,
                color: Color(
                  Theme.of(context).colorScheme.primary.value,
                ),
              ),
            ),
            isSelected: isCategoryFilterVisible,
            icon: const Icon(Icons.filter_list_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              size: 32,
            ),
          )
        ],
      ),
      body: const CategoryList(),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('New expense'),
          icon: const Icon(Icons.add),
          onPressed: () {
            _openAddNewExpenseOverlay(context);
          }),
    );
  }

  void _openAddNewExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
      builder: (builderContext) => const Scaffold(
        body: NewExpense(),
      ),
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}
