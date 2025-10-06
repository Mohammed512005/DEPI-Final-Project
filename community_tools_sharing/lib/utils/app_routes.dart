import 'package:flutter/material.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
  };
}
