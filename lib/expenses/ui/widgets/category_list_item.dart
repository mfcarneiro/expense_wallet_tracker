import 'package:expenses_wallet_tracker/core/util/string_extensions.dart';
import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/domain/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryItem category;
  final int index;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var isCategorySelected = context.select<ExpenseModel, int?>(
        (selection) => selection.isCategorySelected);

    return ChoiceChip(
      padding: const EdgeInsets.all(5.0),
      selected: isCategorySelected == index,
      onSelected: (selected) {
        context.read<ExpenseModel>().isCategorySelected =
            selected ? index : null;
        context.read<ExpenseModel>().toggleFilterByCategory(category);
      },
      showCheckmark: false,
      label: Text(
        category.name.capitalize(),
      ),
      avatar: isCategorySelected == index
          ? const Icon(Icons.check)
          : Icon(categoryIcons[category]),
    );
  }
}
