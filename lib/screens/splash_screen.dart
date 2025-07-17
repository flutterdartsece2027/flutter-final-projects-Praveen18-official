import 'package:flutter/material.dart';
import 'package:agrinova/screens/login_screen.dart';
import 'package:agrinova/screens/main_screen.dart';
import 'package:agrinova/screens/admin_dashboard.dart';
import 'package:agrinova/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      final isAdmin = await AuthService.isAdmin();
      if (isAdmin) {
        Navigator.pushReplacementNamed(context, AdminDashboard.routeName);
      } else {
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
      }
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 100),
              Icon(Icons.agriculture, size: 100, color: Colors.green[900]),
              const SizedBox(height: 24),
              Text(
                'AgriNova',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your Agricultural Marketplace',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[800],
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
