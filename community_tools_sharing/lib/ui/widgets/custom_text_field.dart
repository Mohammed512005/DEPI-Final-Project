import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String hintText;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.grey[400] : const Color(0xff4c7f99),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: isDark
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFE8EFF2),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: buildBorder(isDark, focused: true),
        enabledBorder: buildBorder(isDark),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  OutlineInputBorder buildBorder(bool isDark, {bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: focused
            ? (isDark ? Colors.blueAccent : Colors.blue)
            : (isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE8EFF2)),
        width: focused ? 1.3 : 1,
      ),
    );
  }
}
