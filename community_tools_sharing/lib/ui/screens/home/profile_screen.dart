import 'package:flutter/material.dart';
import 'package:community_tools_sharing/ui/models/profile_section_model.dart';
import 'package:community_tools_sharing/ui/widgets/build_profile_section.dart';
import 'package:community_tools_sharing/ui/widgets/custom_app_bar.dart';
import 'package:community_tools_sharing/utils/app_assets.dart';
import 'package:community_tools_sharing/utils/app_style.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static final List<ProfileSectionModel> profileSections = [
    ProfileSectionModel(
      headTitle: 'My Tools',
      subTitle: 'View and manage all tools you listed.',
      icon: AppAssets.toolIcon,
      routeName: AppRoutes.browse,
    ),
    ProfileSectionModel(
      headTitle: 'My Bookings',
      subTitle: 'See tools you booked or borrowed.',
      icon: AppAssets.bookingIcon,
      routeName: AppRoutes.bookings,
    ),
    ProfileSectionModel(
      headTitle: 'Reviews',
      subTitle: 'Check feedback you received or gave.',
      icon: AppAssets.reviewIcon,
      routeName: AppRoutes.notf,
    ),
    ProfileSectionModel(
      headTitle: 'Settings',
      subTitle: 'Manage your profile and preferences.',
      icon: AppAssets.settingIcon,
      routeName: AppRoutes.profile,
    ),
    ProfileSectionModel(
      headTitle: 'Logout',
      subTitle: 'Sign out from your account.',
      icon: AppAssets.logoutIcon,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0D0D) : Colors.white,
      appBar: builAppBar(context, title: 'Profile'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(AppAssets.profileImage),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ethan Carter',
                      style: AppStyle.mainTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ethan.carter@email.com',
                      style: AppStyle.kSecondaryTextStyle.copyWith(
                        fontSize: 15,
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFE8EFF2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            'Reputation: 4.8',
                            style: TextStyle(
                              color:
                                  isDark ? Colors.grey[300] : Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              /// Profile sections list
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BuildProfileSection(
                        profileSectionModel: profileSections[index],
                      ),
                    );
                  },
                  childCount: profileSections.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
