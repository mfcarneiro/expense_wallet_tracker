import 'package:expenses_wallet_tracker/expenses/application/model/expense_model.dart';
import 'package:expenses_wallet_tracker/expenses/ui/screen/expenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp(
    ChangeNotifierProvider<ExpenseModel>(
      create: (context) => ExpenseModel(),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
          home: const ExpensesScreen(),
        );
      },
    ),
  );
}

void setup() {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
}
