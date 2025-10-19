import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:community_tools_sharing/utils/app_assets.dart';
import 'package:community_tools_sharing/utils/app_style.dart';

class ToolDetailsScreen extends StatelessWidget {
  const ToolDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tool Details',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            // Tool Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppAssets.homeImage2, // 🔹 From your assets file
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Tool Name
            Text(
              'Power Drill',
              style: AppStyle.mainTextStyle.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            // Description
            Text(
              'This power drill is perfect for any home improvement project. It\'s lightweight, powerful, and easy to use.',
              style: AppStyle.kSecondaryTextStyle.copyWith(fontSize: 16),
              softWrap: true,
            ),

            const SizedBox(height: 10),

            // Condition
            Text(
              'Condition',
              style: AppStyle.mainTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'New',
              style: AppStyle.kSecondaryTextStyle.copyWith(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Owner Info
            Text(
              'Owner',
              style: AppStyle.mainTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    AppAssets.profileImage,
                  ), // 🔹 From assets
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: AppStyle.mainTextStyle.copyWith(fontSize: 16),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: 4.8,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 18,
                        ),
                        Text(' 4.8 ', style: AppStyle.kSecondaryTextStyle),
                        Text(
                          '(12 reviews)',
                          style: AppStyle.kSecondaryTextStyle.copyWith(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Price
            Text(
              'Rental Price',
              style: AppStyle.mainTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '\$50 / day',
              style: AppStyle.kSecondaryTextStyle.copyWith(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                // TODO: Add booking logic or navigation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF1294D4),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
