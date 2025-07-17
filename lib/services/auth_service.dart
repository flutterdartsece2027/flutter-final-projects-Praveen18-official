import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userEmailKey = 'user_email';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _isAdminKey = 'is_admin';
  
  // Admin credentials
  static const String _adminEmail = 'admin@gmail.com';
  static const String _adminPassword = 'admin123';

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Check if user is admin
  static Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isAdminKey) ?? false;
  }

  // Get current user email
  static Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Login user
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check for admin login
    if (email == _adminEmail && password == _adminPassword) {
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setBool(_isAdminKey, true);
      await prefs.setString(_userEmailKey, email);
      return true;
    }
    
    // For regular users, you can add additional validation here
    // For now, we'll just accept any non-admin login
    if (email.isNotEmpty && password.isNotEmpty) {
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setBool(_isAdminKey, false);
      await prefs.setString(_userEmailKey, email);
      return true;
    }
    
    return false;
  }

  // Logout user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_isAdminKey);
    await prefs.remove(_userEmailKey);
  }

  // Check if current user is admin
  static Future<bool> checkIfAdmin(String email, String password) async {
    return email == _adminEmail && password == _adminPassword;
  }
}
