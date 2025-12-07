import 'package:community_tools_sharing/ui/screens/forget_password_screen.dart';
import 'package:community_tools_sharing/ui/screens/notification_screen.dart';
import 'package:community_tools_sharing/ui/screens/reset_password_screen.dart';
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
  static const String forgetPassword = '/forgetPassword';
  static const String resetPassword = '/resetPassword';
  static const String notf = '/notifications';

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

    // ❌ Removed the invalid ToolDetailsScreen() here
    // toolDetails: (context) => const ToolDetailsScreen(),

    forgetPassword: (context) => const ForgotPasswordScreen(),
    resetPassword: (context) => const ResetPasswordScreen(),
    notf: (context) => NotificationScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case toolDetails:
        final args = settings.arguments;
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => ToolDetailsScreen(
              title: args['title'],
              image: args['image'],
              description: args['description'],
              condition: args['condition'],
              ownerName: args['ownerName'],
              price: args['price'],
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Missing tool data for Tool Details screen',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ),
          );
        }

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
