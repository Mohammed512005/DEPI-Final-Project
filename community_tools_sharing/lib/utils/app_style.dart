import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppStyle {
  //example:

  // static TextStyle bold16Black = GoogleFonts.lato(
  //   textStyle: TextStyle(
  //     color: AppColors.black,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 16,
  //   ),
  // );

  // static const bold20GoldStyle = TextStyle(
  //   fontSize: 20,
  //   fontWeight: FontWeight.w700,
  //   color: AppColors.gold,
  // );

  static const TextStyle kSecondaryTextStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle mainTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
