import 'package:flutter/material.dart';

class UserActivityScreen extends StatelessWidget {
  const UserActivityScreen({super.key});
  
  static const String routeName = '/user-activity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Activity'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'User Activity Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
