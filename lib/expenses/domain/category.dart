import 'package:flutter/material.dart';

const categoryIcons = {
  CategoryItem.groceries: Icons.lunch_dining_outlined,
  CategoryItem.bills: Icons.receipt_outlined,
  CategoryItem.car: Icons.car_repair_outlined,
  CategoryItem.expenses: Icons.payments_outlined,
  CategoryItem.eletronics: Icons.kitchen_outlined,
  CategoryItem.mall: Icons.local_mall_outlined
};

enum CategoryItem {
  groceries,
  bills,
  car,
  expenses,
  eletronics,
  mall,
}
