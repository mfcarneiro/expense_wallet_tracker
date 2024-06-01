import 'package:expenses_wallet_tracker/core/theme/theme.dart';
import 'package:expenses_wallet_tracker/core/theme/theme_config.dart';
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
        var brightness = View.of(context).platformDispatcher.platformBrightness;
        TextTheme textTheme = createTextTheme(context, "Tajawal", "Tajawal");
        MaterialTheme theme = MaterialTheme(textTheme);
        return MaterialApp(
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          themeMode: ThemeMode.system,
          darkTheme: theme.dark(),
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
