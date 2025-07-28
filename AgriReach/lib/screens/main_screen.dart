import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrireach/providers/cart_provider.dart';
import 'package:agrireach/services/auth_service.dart';
import 'package:agrireach/screens/buy_crops_screen.dart';
import 'package:agrireach/screens/cart_screen.dart';
import 'package:agrireach/screens/login_screen.dart';
import 'package:agrireach/screens/nearby_services_screen.dart';
import 'package:agrireach/screens/orders_history_screen.dart';
import 'package:agrireach/screens/support_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const BuyCropsScreen(),
    const OrdersHistoryScreen(),
    const CartScreen(),
    const SupportScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 4) { // Nearby Services tab
      Navigator.pushNamed(context, NearbyServicesScreen.routeName);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Check for any navigation arguments when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('selectedIndex')) {
        final index = args['selectedIndex'] as int;
        if (index >= 0 && index < _screens.length) {
          setState(() {
            _selectedIndex = index;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgriReach'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: _buildDrawer(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Nearby',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'User',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 0);
            },
            selected: _selectedIndex == 0,
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 1);
            },
            selected: _selectedIndex == 1,
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Consumer<CartProvider>(
              builder: (ctx, cart, _) => Row(
                children: [
                  const Text('Cart'),
                  if (cart.itemCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 2);
            },
            selected: _selectedIndex == 2,
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Support'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 3);
            },
            selected: _selectedIndex == 3,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Nearby Services'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, NearbyServicesScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              Navigator.pop(context);
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true) {
                await AuthService.logout();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
