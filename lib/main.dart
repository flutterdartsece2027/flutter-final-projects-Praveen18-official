import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/buy_crops_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_history_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/support_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/admin_dashboard.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const AgriNovaApp());
}

class AgriNovaApp extends StatelessWidget {
  const AgriNovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'AgriNova',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green[800],
              side: BorderSide(color: Colors.green.shade700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          MainScreen.routeName: (ctx) => const MainScreen(),
          AdminDashboard.routeName: (ctx) => const AdminDashboard(),
          CheckoutScreen.routeName: (ctx) => const CheckoutScreen(),
          // Add other routes here as needed
        },
        onGenerateRoute: (settings) {
          // Handle 404
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              appBar: AppBar(title: const Text('Page Not Found')),
              body: Center(
                child: Text('Route ${settings.name} not found!'),
              ),
            ),
          );
        },
      ),
    );
  }
}