import 'dart:convert';

import 'package:myWM/models/notifikasi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String _storageKey = 'notifications';

  Future<List<NotificationItem>> getNotifications({bool unreadOnly = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? notificationsJson = prefs.getString(_storageKey);
    if (notificationsJson == null) {
      return [];
    }
    final List<dynamic> decoded = jsonDecode(notificationsJson);
    final List<NotificationItem> notifications = decoded.map((item) => NotificationItem.fromMap(item)).toList();
    
    // Filter expired notifications
    notifications.removeWhere((notification) => notification.expiryDate.isBefore(DateTime.now()));
    
    if (unreadOnly) {
      notifications.removeWhere((notification) => notification.isRead);
    }
    
    return notifications;
  }

  Future<void> addNotification(NotificationItem notification) async {
    final prefs = await SharedPreferences.getInstance();
    final List<NotificationItem> notifications = await getNotifications();
    notifications.insert(0, notification);
    await prefs.setString(_storageKey, jsonEncode(notifications.map((e) => e.toMap()).toList()));
  }

  Future<void> markAsRead(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<NotificationItem> notifications = await getNotifications();
    final index = notifications.indexWhere((notification) => notification.id == notificationId);
    if (index != -1) {
      notifications[index].isRead = true;
      await prefs.setString(_storageKey, jsonEncode(notifications.map((e) => e.toMap()).toList()));
    }
  }

  Future<void> cleanExpiredNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<NotificationItem> notifications = await getNotifications();
    notifications.removeWhere((notification) => notification.expiryDate.isBefore(DateTime.now()));
    await prefs.setString(_storageKey, jsonEncode(notifications.map((e) => e.toMap()).toList()));
  }

  Future<void> clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
  Future<int> getUnreadNotificationsCount() async {
    final notifications = await getNotifications(unreadOnly: true);
    return notifications.length;
  }
}

//================================================================================================================================================================

// class NotificationService {
//   static const String _storageKey = 'notifications';

//   Future<List<NotificationItem>> getNotifications() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? notificationsJson = prefs.getString(_storageKey);
//     if (notificationsJson == null) {
//       return [];
//     }
//     final List<dynamic> decoded = jsonDecode(notificationsJson);
//     return decoded.map((item) => NotificationItem.fromMap(item)).toList();
//   }

//   Future<void> addNotification(NotificationItem notification) async {
//     final prefs = await SharedPreferences.getInstance();
//     final notifications = await getNotifications();
//     notifications.insert(0, notification);
//     await prefs.setString(_storageKey, jsonEncode(notifications.map((e) => e.toMap()).toList()));
//   }

//   Future<void> clearNotifications() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_storageKey);
//   }
// }