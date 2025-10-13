import 'package:community_tools_sharing/ui/widgets/custom_app_bar.dart';
import 'package:community_tools_sharing/ui/widgets/sign_in_view_body.dart';
import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: builAppBar(context, title: "Sign In"),
      body: SignInViewBody(),
    );
  }
}
