import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:community_tools_sharing/ui/models/profile_section_model.dart';
import 'package:community_tools_sharing/ui/screens/home/browse_screen.dart';
import 'package:community_tools_sharing/ui/screens/home/booking_screen.dart';
import 'package:community_tools_sharing/ui/screens/notification_screen.dart';
import 'package:community_tools_sharing/ui/screens/auth/sign_in_screen.dart';



class BuildProfileSection extends StatelessWidget {
  const BuildProfileSection({
    super.key,
    required this.profileSectionModel,
  });

  final ProfileSectionModel profileSectionModel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () async {
  switch (profileSectionModel.headTitle) {
    case 'My Tools':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BrowseScreen()),
      );
      break;

    case 'My Bookings':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BookingScreen()),
      );
      break;

    case 'Reviews':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NotificationScreen()),
      );
      break;

    case 'Settings':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings coming soon')),
      );
      break;

    case 'Logout':
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
      break;

    default:
  }
},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F8FA),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2B2B2B)
                    : const Color(0xFFE8EFF2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(profileSectionModel.icon,
                    color: isDark ? Colors.white70 : Colors.black87),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileSectionModel.headTitle,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profileSectionModel.subTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Color(0xFF009CDE),
            ),
          ],
        ),
      ),
    );
  }
}
