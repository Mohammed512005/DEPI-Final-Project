import 'package:community_tools_sharing/services/notification_service.dart';
import 'package:community_tools_sharing/ui/widgets/category_chip.dart';
import 'package:community_tools_sharing/ui/widgets/nearby_item_card.dart';
import 'package:community_tools_sharing/ui/widgets/search_bar.dart';
import 'package:community_tools_sharing/utils/app_assets.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:community_tools_sharing/ui/screens/tool_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
      'description': 'A reliable lawn mower great for maintaining your yard.',
      'owner': 'Alice Johnson',
      'condition': 'Good',
    },
    {
      'title': 'Drill',
      'price': 'Free',
      'distance': '0.8 miles',
      'image': AppAssets.homeImage2,
      'description': 'Powerful drill suitable for construction and repairs.',
      'owner': 'Jake Smith',
      'condition': 'Like New',
    },
    {
      'title': 'Blender',
      'price': '\$5/day',
      'distance': '2.5 miles',
      'image': AppAssets.homeImage3,
      'description': 'Perfect for smoothies and kitchen tasks.',
      'owner': 'Maria Lopez',
      'condition': 'New',
    },
    {
      'title': 'Saw',
      'price': '\$15/day',
      'distance': '1.5 miles',
      'image': AppAssets.homeImage4,
      'description': 'Heavy-duty saw ideal for wood-cutting projects.',
      'owner': 'David Lee',
      'condition': 'Used',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text("Login first")));
    }

    final currentUserId = currentUser.id;

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
                // 🔔 Notifications
                StreamBuilder<int>(
                  stream: NotificationService().getUnreadCount(currentUserId),
                  builder: (context, snapshot) {
                    int count = snapshot.data ?? 0;

                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.notf);
                          },
                          icon: const Icon(Icons.notifications),
                        ),
                        if (count > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                count.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const Expanded(
                  child: Center(
                    child: Text(
                      'ConnecTools',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              ],
            ),

            const SizedBox(height: 10),

            // Search bar
            const CustomSearchBar(),
            const SizedBox(height: 10),

            // Categories
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ToolDetailsScreen(
                            title: item['title'],
                            image: item['image'],
                            description: item['description'],
                            condition: item['condition'],
                            ownerName: item['owner'],
                            price: item['price'],
                          ),
                        ),
                      );
                    },
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
