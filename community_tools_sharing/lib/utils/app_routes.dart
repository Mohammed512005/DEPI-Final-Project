import 'package:flutter/material.dart';
import 'package:community_tools_sharing/ui/screens/auth/complete_profile.dart';
import 'package:community_tools_sharing/ui/screens/auth/sign_in_screen.dart';
import 'package:community_tools_sharing/ui/screens/auth/sign_up_screen.dart';
import 'package:community_tools_sharing/ui/screens/home/add_tool_screen.dart';
import 'package:community_tools_sharing/ui/screens/home/booking_screen.dart';
import 'package:community_tools_sharing/ui/screens/home/browse_screen.dart';
import 'package:community_tools_sharing/ui/screens/auth/mail_verification_screen.dart';
import 'package:community_tools_sharing/ui/screens/home/main_layout.dart';
import 'package:community_tools_sharing/ui/screens/home/profile_screen.dart';
import 'package:community_tools_sharing/ui/screens/onboarding_screen.dart';
import 'package:community_tools_sharing/ui/screens/tool_details_screen.dart';
import '../ui/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String mailVerification = '/mail_verification';
  static const String browse = '/browse';
  static const String addTool = '/add_tool';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String register = '/register';
  static const String toolDetails = '/toolDetails';
  static const String completeProfile = '/completeProfile';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingView(),
    mailVerification: (context) => const MailVerificationScreen(),
    home: (context) => const MainLayout(),
    browse: (context) => const BrowseScreen(),
    addTool: (context) => const AddToolScreen(),
    bookings: (context) => const BookingScreen(),
    profile: (context) => const ProfileScreen(),
    login: (context) => const SignInScreen(),
    register: (context) => const SignUpScreen(),
    toolDetails: (context) => const ToolDetailsScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case completeProfile:
        final args = settings.arguments;
        if (args is Map<String, String>) {
          return MaterialPageRoute(
            builder: (_) => CompleteProfile(
              email: args['email']!,
              password: args['password']!,
            ),
          );
        } else {
          // 🧱 fallback if arguments are missing
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Missing required data (email & password) for Complete Profile',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

      default:
        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
        return null;
    }
  }
}
