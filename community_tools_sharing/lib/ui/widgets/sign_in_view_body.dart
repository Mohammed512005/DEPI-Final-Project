import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:community_tools_sharing/ui/widgets/custom_text_field.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:community_tools_sharing/utils/app_style.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Password',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 358,
              child: Text(
                'Forgot Password?',
                style: AppStyle.kSecondaryTextStyle,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(text: 'Sign In', onPressed: () {}),
            SizedBox(height: 400),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have an account? ',
                  style: AppStyle.kSecondaryTextStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: Text('Sign Up', style: AppStyle.kSecondaryTextStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
