import 'package:flutter/material.dart';
import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:community_tools_sharing/ui/widgets/custom_text_field.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:community_tools_sharing/utils/app_style.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onNext(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms & Conditions')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // ✅ Navigate to CompleteProfile screen with credentials
    Navigator.pushNamed(
      context,
      AppRoutes.completeProfile,
      arguments: {'email': email, 'password': password},
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.app_registration,
                      size: size.width * 0.18,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Create Account ✨',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Join our community and start sharing tools',
                      style: AppStyle.kSecondaryTextStyle.copyWith(
                        fontSize: size.width * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.06),

              // --- Email Field ---
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),

              // --- Password Field ---
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'Password',
                textInputType: TextInputType.visiblePassword,
                obscureText: _obscurePassword,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey.shade600,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 16),

              // --- Confirm Password Field ---
              CustomTextFormField(
                controller: _confirmController,
                hintText: 'Confirm Password',
                textInputType: TextInputType.visiblePassword,
                obscureText: _obscureConfirm,
                prefixIcon: Icon(
                  Icons.lock_reset_outlined,
                  color: Colors.grey.shade600,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
              SizedBox(height: size.height * 0.03),

              // --- Terms & Conditions ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    activeColor: Colors.deepPurple,
                    onChanged: (v) =>
                        setState(() => _agreeToTerms = v ?? false),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: AppStyle.kSecondaryTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: AppStyle.kSecondaryTextStyle.copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),

              // --- Next Button ---
              CustomButton(
                text: "Next",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                // => _onNext(context),
              ),

              SizedBox(height: size.height * 0.05),

              // --- Already Have Account ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppStyle.kSecondaryTextStyle,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    ),
                    child: Text(
                      'Sign In',
                      style: AppStyle.kSecondaryTextStyle.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
