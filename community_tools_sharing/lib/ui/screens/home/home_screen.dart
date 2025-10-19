import 'package:community_tools_sharing/ui/widgets/category_chip.dart';
import 'package:community_tools_sharing/ui/widgets/nearby_item_card.dart';
import 'package:community_tools_sharing/ui/widgets/search_bar.dart';
import 'package:community_tools_sharing/utils/app_assets.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> categories = const [
    'All',
    'Gardening',
    'Power Tools',
    'Kitchen',
  ];

  final List<Map<String, dynamic>> nearbyItems = const [
    {
      'title': 'Lawn Mower',
      'price': '\$10/day',
      'distance': '1.2 miles',
      'image': AppAssets.homeImage1,
    },
    {
      'title': 'Drill',
      'price': 'Free',
      'distance': '0.8 miles',
      'image': AppAssets.homeImage2,
    },
    {
      'title': 'Blender',
      'price': '\$5/day',
      'distance': '2.5 miles',
      'image': AppAssets.homeImage3,
    },
    {
      'title': 'Saw',
      'price': '\$15/day',
      'distance': '1.5 miles',
      'image': AppAssets.homeImage4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Center(
                    child: const Text(
                      'ConnecTools',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: open filter/sort modal
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Search bar
            const CustomSearchBar(),
            const SizedBox(height: 10),

            // Category list
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return CategoryChip(label: categories[index]);
                },
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Nearby',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Nearby Items
            Expanded(
              child: GridView.builder(
                itemCount: nearbyItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final item = nearbyItems[index];
                  return NearbyItemCard(
                    title: item['title'],
                    price: item['price'],
                    distance: item['distance'],
                    image: item['image'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
