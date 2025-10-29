import 'package:community_tools_sharing/services/local_storage_service.dart';
import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Run async logic here
    final onboardingShown = await LocalStorageService.isOnboardingShown();
    final loggedIn = await LocalStorageService.isLoggedIn();

    // Add small splash delay
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      !onboardingShown
          ? AppRoutes.onboarding
          : (loggedIn ? AppRoutes.home : AppRoutes.login),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor,
      body: Center(
        child: Image.asset(AppAssets.splash, height: double.infinity),
      ),
    );
  }
}
