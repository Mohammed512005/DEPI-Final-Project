import 'package:community_tools_sharing/ui/widgets/custom_app_bar.dart';
import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:community_tools_sharing/ui/widgets/custom_text_field.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:community_tools_sharing/utils/app_style.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builAppBar(
        context,
        title: 'Reset Password',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              Text('Reset Your Password', style: AppStyle.mainTextStyle),
              SizedBox(height: 30),

              CustomTextFormField(
                hintText: 'New Password',
                textInputType: TextInputType.visiblePassword,

                controller: _newPasswordController,

                obscureText: _obscurePassword,

                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              SizedBox(height: 20),

              CustomTextFormField(
                hintText: 'Confirm Password',
                textInputType: TextInputType.visiblePassword,

                controller: _confirmPasswordController,

                obscureText: _obscurePassword,

                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              SizedBox(height: 20),

              Text(
                '8+ characters, include numbers',
                style: AppStyle.kSecondaryTextStyle,
              ),

              SizedBox(height: 20),
              CustomButton(text: 'Update Password', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
