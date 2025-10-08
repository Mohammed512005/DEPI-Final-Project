import 'package:community_tools_sharing/ui/screens/sign_in_screen.dart';
import 'package:community_tools_sharing/ui/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const SignInScreen(),
    home: (context) => const HomeScreen(),
    register: (context) => const SignUpScreen(),
  };
}
