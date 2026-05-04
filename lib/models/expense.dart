import 'package:flutter/material.dart';

enum ExpenseSplitType { equal, percentage, exact, weight }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String paidBy;
  final Map<String, double> split;
  final String? groupName;
  final IconData icon;
  final ExpenseSplitType splitType;
  final double? yourPart;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.paidBy,
    required this.split,
    this.groupName,
    this.icon = Icons.receipt_long,
    this.splitType = ExpenseSplitType.equal,
    this.yourPart,
  });

  String get formattedDate {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Hoje';
    if (diff.inDays == 1) return 'Ontem';
    return '${diff.inDays} dias atrás';
  }

  // Mock expenses for a specific group
  static List<Expense> getMockExpenses(String groupId) {
    if (groupId == '1') {
      return [
        Expense(
          id: 'e1',
          title: 'Jantar no Cais',
          amount: 380.0,
          date: DateTime.now().subtract(const Duration(days: 1)),
          paidBy: 'Você',
          split: {'Você': 76, 'Marina': 76, 'Lucas': 76, 'Ana': 76, 'Pedro': 76},
          icon: Icons.restaurant,
          splitType: ExpenseSplitType.equal,
          yourPart: 76.0,
        ),
        Expense(
          id: 'e2',
          title: 'Combustível',
          amount: 150.0,
          date: DateTime.now().subtract(const Duration(days: 2)),
          paidBy: 'Lucas',
          split: {'Você': 30, 'Marina': 30, 'Lucas': 30, 'Ana': 30, 'Pedro': 30},
          icon: Icons.local_gas_station,
          splitType: ExpenseSplitType.equal,
          yourPart: 30.0,
        ),
        Expense(
          id: 'e3',
          title: 'Reserva Airbnb',
          amount: 1920.80,
          date: DateTime.now().subtract(const Duration(days: 3)),
          paidBy: 'Marina',
          split: {'Você': 384, 'Marina': 384, 'Lucas': 384, 'Ana': 384, 'Pedro': 384.80},
          icon: Icons.hotel,
          splitType: ExpenseSplitType.equal,
          yourPart: 384.0,
        ),
      ];
    }
    return [
      Expense(
        id: 'e4',
        title: 'Mercado',
        amount: 150.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
        paidBy: 'Você',
        split: {'Você': 75.0, 'Ana': 75.0},
        icon: Icons.shopping_cart,
        yourPart: 75.0,
      ),
    ];
  }

  // Mock expenses for the activity/debt summary screen
  static List<Expense> get mockRecentActivity => [
        Expense(
          id: 'a1',
          title: 'Supermercado BH',
          amount: 45.0,
          date: DateTime.now().subtract(const Duration(hours: 3)),
          paidBy: 'Você',
          split: {},
          groupName: 'Casa',
          icon: Icons.shopping_cart,
          yourPart: 45.0,
        ),
        Expense(
          id: 'a2',
          title: 'Jantar Outback',
          amount: 125.0,
          date: DateTime.now().subtract(const Duration(days: 1)),
          paidBy: 'João',
          split: {},
          groupName: 'Amigos',
          icon: Icons.restaurant,
          yourPart: 125.0,
        ),
        Expense(
          id: 'a3',
          title: 'Uber Viagem',
          amount: 22.90,
          date: DateTime.now().subtract(const Duration(days: 2)),
          paidBy: 'Você',
          split: {},
          groupName: 'Individual',
          icon: Icons.directions_car,
          yourPart: 22.90,
        ),
      ];
}
