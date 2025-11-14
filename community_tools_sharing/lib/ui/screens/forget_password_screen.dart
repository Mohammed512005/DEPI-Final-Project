import 'package:community_tools_sharing/ui/widgets/custom_app_bar.dart';
import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:community_tools_sharing/ui/widgets/custom_text_field.dart';
import 'package:community_tools_sharing/utils/app_assets.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:community_tools_sharing/utils/app_style.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builAppBar(
        context,
        title: 'Forgot Password',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.asset(AppAssets.forgetPassword),
              ),
              SizedBox(height: 16),

              Text(
                'Forgot Password?',
                style: AppStyle.mainTextStyle.copyWith(fontSize: 24),
              ),
              Text(
                'Enter your registered email to reset your',
                style: AppStyle.mainTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                ' password.',
                style: AppStyle.mainTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 30),

              CustomTextFormField(
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade600,
                ),
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              CustomButton(
                text: 'Send Reset Link',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.resetPassword);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
