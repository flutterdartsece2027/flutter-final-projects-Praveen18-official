import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  final List<Map<String, dynamic>> transactions = const [
    {'user': 'Kumar', 'amount': 200, 'date': '2025-07-05'},
    {'user': 'Anita', 'amount': 450, 'date': '2025-07-04'},
    {'user': 'Raj', 'amount': 300, 'date': '2025-07-03'},
    {'user': 'Meena', 'amount': 150, 'date': '2025-07-02'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Money Transactions')),
      body: transactions.isEmpty
          ? const Center(child: Text('No transactions available'))
          : ListView.separated(
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final txn = transactions[index];
          return ListTile(
            leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
            title: Text('From: ${txn['user']}'),
            subtitle: Text('Date: ${txn['date']}'),
            trailing: Text(
              '₹${txn['amount']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
