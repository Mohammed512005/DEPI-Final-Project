import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:community_tools_sharing/ui/widgets/custom_text_field.dart';
import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:community_tools_sharing/utils/app_style.dart';
import 'package:flutter/material.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key, required this.status});
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'password',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Confirm password',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'National ID',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'I agree to the Terms and Conditions',
                  style: AppStyle.kSecondaryTextStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(width: 50),
                Checkbox(
                  activeColor: Color(0xFFCEDDE8),
                  focusColor: Color(0xFFCEDDE8),
                  value: status,
                  onChanged: (value) {
                    value = status;
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomButton(text: "Sign Up", onPressed: () {}),
            SizedBox(height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: AppStyle.kSecondaryTextStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: Text('Sign In', style: AppStyle.kSecondaryTextStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
