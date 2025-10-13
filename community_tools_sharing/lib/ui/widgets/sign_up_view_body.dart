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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.app_registration,
                      size: size.width * 0.18,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Create Account ✨',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xFF1E1E1E,
                        ), // dark gray/black for modern look
                      ),
                      textAlign: TextAlign.center,
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

              // ---------- Email ----------
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade600,
                ),
                // TODO: Add email validation
              ),
              const SizedBox(height: 16),

              // ---------- Password ----------
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
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                // TODO: Add password validation
              ),
              const SizedBox(height: 16),

              // ---------- Confirm Password ----------
              CustomTextFormField(
                controller: _confirmPasswordController,
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
                  onPressed: () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  },
                ),
                // TODO: Validate matching passwords
              ),
              const SizedBox(height: 16),

              // ---------- National ID ----------
              CustomTextFormField(
                controller: _nationalIdController,
                hintText: 'National ID',
                textInputType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.badge_outlined,
                  color: Colors.grey.shade600,
                ),
                // TODO: Validate ID format
              ),

              SizedBox(height: size.height * 0.03),

              // ---------- Terms & Conditions ----------
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    activeColor: Colors.deepPurple,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
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
                            // TODO: Navigate to T&C page
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              // ---------- Sign Up Button ----------
              CustomButton(
                text: "Sign Up",
                onPressed: () {
                  // TODO: Add register logic
                  if (_agreeToTerms) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please agree to the Terms & Conditions first',
                        ),
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: size.height * 0.05),

              // ---------- Already Have Account ----------
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

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
