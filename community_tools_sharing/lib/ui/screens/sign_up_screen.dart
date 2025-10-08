import 'package:community_tools_sharing/ui/widgets/custom_app_bar.dart';
import 'package:community_tools_sharing/ui/widgets/sign_up_view_body.dart';
import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: builAppBar(title: "Sign Up", context),

      body: SignUpViewBody(status: false),
    );
  }
}
