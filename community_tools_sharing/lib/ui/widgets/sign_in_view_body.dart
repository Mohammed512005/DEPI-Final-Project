import 'package:flutter/material.dart';
import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:community_tools_sharing/ui/widgets/custom_text_field.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:community_tools_sharing/utils/app_style.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Logo / Header ----------
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.construction,
                      size: size.width * 0.18,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome Back 👋',
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
                      'Sign in to continue',
                      style: AppStyle.kSecondaryTextStyle.copyWith(
                        fontSize: size.width * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.07),

              // ---------- Email Field ----------
              CustomTextFormField(
                controller: _emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade600,
                ),
                // TODO: Add email validation logic
              ),
              const SizedBox(height: 20),

              // ---------- Password Field ----------
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
                // TODO: Add password validation logic
              ),

              SizedBox(height: size.height * 0.01),

              // ---------- Forgot Password ----------
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Add "Forgot Password" screen navigation
                  },
                  child: Text(
                    'Forgot Password?',
                    style: AppStyle.kSecondaryTextStyle.copyWith(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),

              // ---------- Sign In Button ----------
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  // TODO: Add login logic (Firebase/Auth API)
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
              ),
              SizedBox(height: size.height * 0.03),

              // ---------- Divider ----------
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey.shade300),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or'),
                  ),
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),

              // ---------- Sign Up ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppStyle.kSecondaryTextStyle,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    child: Text(
                      'Sign Up',
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
