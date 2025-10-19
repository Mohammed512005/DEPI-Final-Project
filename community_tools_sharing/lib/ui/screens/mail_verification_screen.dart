import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';

class MailVerificationScreen extends StatefulWidget {
  const MailVerificationScreen({super.key});

  @override
  State<MailVerificationScreen> createState() => _MailVerificationScreenState();
}

class _MailVerificationScreenState extends State<MailVerificationScreen> {
  final TextEditingController codeController = TextEditingController();

  // TODO: Add your logic to handle resend timer if needed
  bool isResending = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFF7FAFC),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mail Verification',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),

                        /// Title
                        Text(
                          'Check your mail',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// Subtitle
                        Text(
                          'We sent a 6-digit verification code to your email.\nPlease enter it below to verify your account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.grey[400] : Colors.black54,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 40),

                        /// OTP Input Field
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          cursorColor: isDark ? Colors.white : Colors.black,
                          textStyle: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 55,
                            fieldWidth: 45,
                            inactiveColor: isDark
                                ? Colors.grey[700]!
                                : Colors.black26,
                            activeColor: isDark
                                ? Colors.blueAccent
                                : Colors.blue,
                            selectedColor: isDark
                                ? Colors.blueAccent
                                : Colors.blue,
                            inactiveFillColor: isDark
                                ? const Color(0xFF1E1E1E)
                                : const Color(0xFFEFF5F7),
                            activeFillColor: isDark
                                ? const Color(0xFF1E1E1E)
                                : const Color(0xFFEFF5F7),
                            selectedFillColor: isDark
                                ? const Color(0xFF1E1E1E)
                                : const Color(0xFFEFF5F7),
                            borderWidth: 1.2,
                          ),
                          animationDuration: const Duration(milliseconds: 250),
                          enableActiveFill: true,
                          onChanged: (value) {},
                        ),

                        const SizedBox(height: 40),

                        /// Verify Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              final code = codeController.text.trim();
                              if (code.length == 6) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.home,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please enter the 6-digit code.",
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF009CDE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        /// Resend Code
                        GestureDetector(
                          onTap: isResending
                              ? null
                              : () {
                                  setState(() => isResending = true);
                                  Future.delayed(
                                    const Duration(seconds: 3),
                                    () {
                                      setState(() => isResending = false);
                                    },
                                  );
                                },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Text.rich(
                              TextSpan(
                                text: "Didn’t receive the code? ",
                                style: TextStyle(
                                  color: isDark
                                      ? const Color(0xFF9BB6C1)
                                      : const Color(0xFF648A9D),
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: isResending
                                        ? "Sending..."
                                        : "Resend Code",
                                    style: const TextStyle(
                                      color: Color(0xFF009CDE),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
