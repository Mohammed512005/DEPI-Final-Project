import 'package:community_tools_sharing/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Share Tools",
          body:
              "Borrow and lend tools within your community. Discover a wide range of tools available for your projects.",
          image: buildImage(AppAssets.shareTools),
          decoration: pageDecoration(),
        ),
        PageViewModel(
          title: "Save Money",
          body:
              "Borrow tools from your neighbors and lend out your own to earn money.",
          image: buildImage(AppAssets.borrowTools),
          decoration: pageDecoration(),
        ),
        PageViewModel(
          title: "Connect with neighbors",
          body:
              "Join a community of tool-sharing enthusiasts. Connect with neighbors, borrow tools, and share your own.",
          image: buildImage(AppAssets.connectWithNeighbors),
          decoration: pageDecoration(),
        ),
      ],
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(color: Color(0xFF6C757D), fontWeight: FontWeight.w500),
      ),
      onSkip: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
      next: const Text(
        "Next",
        style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.w600),
      ),
      done: const Text(
        "Done",
        style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.w600),
      ),
      onDone: () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      },
      dotsDecorator: DotsDecorator(
        size: const Size(10, 10),
        color: const Color(0xFFB0BEC5),
        activeColor: const Color(0xFF1E88E5),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      globalBackgroundColor: Colors.white,
      nextFlex: 0,
    );
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 280));

  PageDecoration pageDecoration() => const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: Color(0xFF1E1E1E),
    ),
    bodyTextStyle: TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
    imagePadding: EdgeInsets.only(top: 60),
    pageColor: Colors.white,
    bodyAlignment: Alignment.center,
    titlePadding: EdgeInsets.only(top: 40, bottom: 16),
  );
}
