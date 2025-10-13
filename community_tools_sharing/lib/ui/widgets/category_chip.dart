import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: AppColors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.transparent),
      ),
    );
  }
}
