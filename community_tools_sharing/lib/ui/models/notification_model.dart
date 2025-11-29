import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final bool isRead;
  final DateTime timestamp;

  AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.timestamp,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json, String docId) {
    return AppNotification(
      id: docId,
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
      'isRead': isRead,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
