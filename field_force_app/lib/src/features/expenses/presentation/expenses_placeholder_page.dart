import 'package:flutter/material.dart';

class ExpensesPlaceholderPage extends StatelessWidget {
  const ExpensesPlaceholderPage({super.key});

  static const routePath = '/expenses';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Expenses module coming in Phase 2',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
