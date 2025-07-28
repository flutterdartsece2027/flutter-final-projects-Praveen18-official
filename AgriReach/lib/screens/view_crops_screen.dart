import 'package:flutter/material.dart';

class ViewCropsScreen extends StatelessWidget {
  const ViewCropsScreen({super.key});

  final List<Map<String, dynamic>> crops = const [
    {'name': 'Rice', 'price': 50},
    {'name': 'Maize', 'price': 35},
    {'name': 'Sugarcane', 'price': 45},
    {'name': 'Cotton', 'price': 60},
    {'name': 'Banana', 'price': 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Crops')),
      body: crops.isEmpty
          ? const Center(child: Text('No crops available'))
          : ListView.separated(
        itemCount: crops.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final crop = crops[index];
          return ListTile(
            leading: const Icon(Icons.grass_rounded, color: Colors.green),
            title: Text(crop['name']),
            trailing: Text('₹${crop['price']}/kg'),
          );
        },
      ),
    );
  }
}
