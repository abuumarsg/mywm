import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final Map<String, dynamic> data;
  final DateTime expiryDate;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.data,
    required this.expiryDate,
    this.isRead = false,
  });

  factory NotificationItem.fromRemoteMessage(RemoteMessage message) {
    return NotificationItem(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      timestamp: message.sentTime ?? DateTime.now(),
      data: message.data,
      expiryDate: DateTime.now().add(Duration(days: 30)), // Notifikasi kadaluarsa setelah 30 hari
      isRead: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'data': data,
      'expiryDate': expiryDate.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      timestamp: DateTime.parse(map['timestamp']),
      data: Map<String, dynamic>.from(map['data']),
      expiryDate: DateTime.parse(map['expiryDate']),
      isRead: map['isRead'],
    );
  }
}