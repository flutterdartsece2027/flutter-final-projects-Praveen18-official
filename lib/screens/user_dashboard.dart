import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'buy_crops_screen.dart';
import 'cart_screen.dart';
import 'orders_history_screen.dart';
import 'support_screen.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AgriNova - User Dashboard"),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildCard(
              icon: Icons.shopping_bag,
              label: 'Buy Crops',
              onTap: () {
                Navigator.pushNamed(context, BuyCropsScreen.routeName);
              },
            ),
            _buildCard(
              icon: Icons.history,
              label: 'Orders History',
              onTap: () {
                Navigator.pushNamed(context, OrdersHistoryScreen.routeName);
              },
            ),
            _buildCard(
              icon: Icons.contact_support,
              label: 'Support',
              onTap: () {
                Navigator.pushNamed(context, SupportScreen.routeName);
              },
            ),
            Consumer<CartProvider>(
              builder: (context, cart, child) => _buildCard(
                icon: Icons.shopping_cart,
                label: 'My Cart',
                badgeCount: cart.itemCount,
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    int? badgeCount,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 48, color: Colors.green[700]),
                  const SizedBox(height: 10),
                  Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (badgeCount != null && badgeCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
