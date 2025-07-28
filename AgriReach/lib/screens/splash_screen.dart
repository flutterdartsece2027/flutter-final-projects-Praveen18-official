import 'package:flutter/material.dart';
import 'package:agrireach/screens/login_screen.dart';
import 'package:agrireach/screens/main_screen.dart';
import 'package:agrireach/screens/admin_dashboard.dart';
import 'package:agrireach/services/auth_service.dart';
import 'package:lottie/lottie.dart';

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
    print('SplashScreen: initState called');
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )
      ..addStatusListener((status) {
        print('SplashScreen: Animation status changed to $status');
      });
      
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward().then((_) {
      print('SplashScreen: Animation completed');
    });

    // Add a small delay before checking auth status to ensure the animation starts
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _checkAuthStatus();
      }
    });
  }

  Future<void> _checkAuthStatus() async {
    print('SplashScreen: Checking auth status...');
    try {
      final isLoggedIn = await AuthService.isLoggedIn();
      print('SplashScreen: isLoggedIn = $isLoggedIn');
      
      if (!mounted) {
        print('SplashScreen: Widget not mounted, returning');
        return;
      }
      
      if (isLoggedIn) {
        final isAdmin = await AuthService.isAdmin();
        print('SplashScreen: isAdmin = $isAdmin');
        await Future.delayed(const Duration(seconds: 2)); // Show splash for at least 2 seconds
        
        if (isAdmin) {
          print('SplashScreen: Navigating to AdminDashboard');
          Navigator.pushReplacementNamed(context, AdminDashboard.routeName);
        } else {
          print('SplashScreen: Navigating to MainScreen');
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        }
      } else {
        await Future.delayed(const Duration(seconds: 2)); // Show splash for at least 2 seconds
        print('SplashScreen: Navigating to LoginScreen');
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } catch (e) {
      print('SplashScreen: Error checking auth status: $e');
      // Fallback to login screen if there's an error
      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.shade50,
                  Colors.green.shade100,
                ],
              ),
            ),
          ),
          
          // Main content
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Lottie icon
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.network(
                      'https://assets3.lottiefiles.com/packages/lf20_glplukk2.json',
                      fit: BoxFit.contain,
                      repeat: true,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.agriculture,
                          size: 100,
                          color: Colors.green,
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // App name with animation
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, _) {
                      return Transform.scale(
                        scale: value,
                        child: Text(
                          'AgriReach',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Tagline with fade animation
                  FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
                      ),
                    ),
                    child: Text(
                      'Your Agricultural Marketplace',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Loading indicator with delay
                  FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Version info at bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
                ),
              ),
              child: const Text(
                'Version 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
