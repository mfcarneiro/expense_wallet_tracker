import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/domain/expense.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/expenses_list.dart';
import 'package:expenses_wallet_tracker/expenses/ui/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    Widget emptyExpenseRecord = Center(
      child: Text(
        'You are rocking! No expenses here!',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              size: 32,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          const Text('Chart...'),
          Expanded(
            child: Consumer<ExpenseModel>(
              builder: (context, provider, child) {
                return provider.expenseList.isEmpty
                    ? emptyExpenseRecord
                    : ExpensesList(
                        expenseList: provider.expenseList,
                        onRemoveExpense: _onRemoveExpense,
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New expense'),
        icon: const Icon(Icons.add),
        onPressed: _openAddNewExpenseOverlay,
      ),
    );
  }

  void _onRemoveExpense(Expense expense) {
    final expenseIndex =
        context.read<ExpenseModel>().expenseList.indexOf(expense);

    context.read<ExpenseModel>().removeExpense(expense);

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

  void _openAddNewExpenseOverlay() {
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
