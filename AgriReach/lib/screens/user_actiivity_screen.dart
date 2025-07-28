import 'package:flutter/material.dart';

class UserActivityScreen extends StatelessWidget {
  const UserActivityScreen({super.key});

  final List<String> activities = const [
    'User Kumar viewed "Rice" crop details',
    'User Anita purchased 10kg of Maize',
    'User Raj added Sugarcane to cart',
    'User Meena viewed Banana crop',
    'User Ramesh removed Cotton from cart',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Activities')),
      body: activities.isEmpty
          ? const Center(child: Text('No user activities recorded'))
          : ListView.separated(
        itemCount: activities.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.history, color: Colors.green),
            title: Text(activities[index]),
          );
        },
      ),
    );
  }
}
