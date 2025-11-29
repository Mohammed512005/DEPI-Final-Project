import 'package:community_tools_sharing/ui/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_tools_sharing/services/notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationService _service = NotificationService();

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text("You must be logged in to view notifications"),
        ),
      );
    }

    final String currentUserId = currentUser.id;

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: StreamBuilder<List<AppNotification>>(
        stream: _service.getNotifications(currentUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data!;

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];

              return ListTile(
                title: Text(
                  n.title,
                  style: TextStyle(
                    fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Text(n.body),
                trailing: Text(
                  "${n.timestamp.hour}:${n.timestamp.minute.toString().padLeft(2, '0')}",
                ),
                tileColor: n.isRead
                    ? Colors.white
                    : Colors.blue.withOpacity(0.1),
                onTap: () {
                  _service.markAsRead(n.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
