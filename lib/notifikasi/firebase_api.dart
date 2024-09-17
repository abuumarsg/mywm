// import 'dart:html';

import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:myWM/models/notifikasi_model.dart';
import 'package:myWM/notifikasi/notifikasi_service.dart';
// import 'package:myWM/main.dart';
import 'package:myWM/ui/pages/notifikasi_page.dart';

import '../shared/global_data.dart';
import '../ui/widgets/navigator_without_context.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title : ${message.notification?.title}');
//   print('Body : ${message.notification?.body}');
//   print('Payload : ${message.data}');
// }

// class FirebaseApi {
//   var logger = Logger();
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Channel',
//     description: 'This channel is used for important notification',
//     importance: Importance.defaultImportance,
//   );
//   final _localNotification = FlutterLocalNotificationsPlugin();

//   void handleMessage(RemoteMessage? message)
//   {
//     if (message == null) return;
//       navigatorKey.currentState?.pushNamed(
//         NotifikasiPage.route,
//         arguments: message,
//       );
//   }

//   Future initLocalNotifications() async {
//     // const iOS = IOSInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await _localNotification.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (payload) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
//         logger.i(message);
//         handleMessage(message);
//       },
//     );
//     final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//   // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   // Future<void> initLocalNotifications() async {
//   //   const AndroidInitializationSettings initializationSettingsAndroid =
//   //       AndroidInitializationSettings('@mipmap/ic_launcher');
//   //   final DarwinInitializationSettings initializationSettingsDarwin =
//   //     DarwinInitializationSettings(
//   //       requestAlertPermission: true,
//   //       requestBadgePermission: true,
//   //       requestSoundPermission: true,
//   //     );
//   //   final LinuxInitializationSettings initializationSettingsLinux =
//   //       LinuxInitializationSettings(defaultActionName: 'Open notification');
//   //   final InitializationSettings initializationSettings = InitializationSettings(
//   //     android: initializationSettingsAndroid,
//   //     iOS: initializationSettingsDarwin,
//   //     macOS: initializationSettingsDarwin,
//   //     linux: initializationSettingsLinux,
//   //   );
//   //   await flutterLocalNotificationsPlugin.initialize(
//   //     initializationSettings,
//   //     onDidReceiveNotificationResponse:
//   //         (NotificationResponse notificationResponse) {
//   //       // Handle notification tapped logic here
//   //     },
//   //   );
//   // }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;

//       _localNotification.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             icon: '@drawable/ic_launcher',
//           ),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMtoken = await _firebaseMessaging.getToken();
//     print('Token : $fCMtoken');
//     logger.i(fCMtoken);
//     initPushNotifications();
//     initLocalNotifications();
//   }
// }


//====================================================================================================================================================================

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
  // Note: Avoid complex operations here as this runs in a separate isolate
}

class FirebaseApi {
  final logger = Logger();
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  final _notificationService = NotificationService();
  ValueNotifier<List<NotificationItem>> notificationsNotifier = ValueNotifier([]);
  
  final _notificationStreamController = StreamController<NotificationItem>.broadcast();
  Stream<NotificationItem> get notificationStream => _notificationStreamController.stream;

  final _androidChannel = const AndroidNotificationChannel(
    'mywm_notification',
    // 'high_importance_channel',
    'myWM Notification',
    description: 'This channel is used for important notification',
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('mywm'),
  );

  Future<void> handleMessage(RemoteMessage message) async {
    if (message.data['type'] == 'notification' || message.data['type'] == null) {
      final notification = NotificationItem.fromRemoteMessage(message);
      await _notificationService.addNotification(notification);
      _updateBadge();
      _notificationStreamController.sink.add(notification);
      notificationsNotifier.value = [notification, ...notificationsNotifier.value];

      navigatorKey.currentState?.pushNamed(
        NotifikasiPage.route,
        arguments: message,
      );
    }
  }
  Future<void> _updateBadge() async {
    final unreadCount = await _notificationService.getUnreadNotificationsCount();
    logger.i('Unread notifications: $unreadCount');
    // await _firebaseMessaging.setApplicationBadgeNumber(unreadCount);
    // final platform = _localNotification.resolvePlatformSpecificImplementation<
    //     IOSFlutterLocalNotificationsPlugin>();
    // if (platform != null) {
    //   await platform.setApplicationIconBadgeNumber(unreadCount);
    // }
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    
    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload ?? '{}'));
        handleMessage(message);
      },
    );

    final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) return;
      await _notificationService.addNotification(NotificationItem.fromRemoteMessage(message));

      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('mywm'),
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    logger.i('FCM Token: $fcmToken');
    tokenUser = fcmToken!;
    
    await initPushNotifications();
    await initLocalNotifications();
  }
  Future<List<NotificationItem>> getNotifications() async {
    // This method fetches all notifications from your storage
    return await _notificationService.getNotifications();
  }
}



//====================================================================================================================================================================


// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   final _localNotification = FlutterLocalNotificationsPlugin();
//   final _notificationService = NotificationService();
//   final _notificationStreamController = StreamController<List<NotificationItem>>.broadcast();

//   Stream<List<NotificationItem>> get notificationStream => _notificationStreamController.stream;


//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.high,
//   );

//   Future<void> initLocalNotifications() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await _localNotification.initialize(settings, onDidReceiveNotificationResponse: (details) {
//       final data = jsonDecode(details.payload ?? '{}');
//       _handleMessage(data);
//     });

//     final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future<void> initPushNotifications() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       final notification = NotificationItem.fromRemoteMessage(message);
//       await _notificationService.addNotification(notification);

//       _notificationStreamController.sink.add(await _notificationService.getNotifications());

//       _showLocalNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       _notificationStreamController.sink.add(await _notificationService.getNotifications());
//       _handleMessage(message);
//     });
//   }

//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     final notification = message.notification;
//     if (notification == null) return;

//     await _localNotification.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           channelDescription: 'This channel is used for important notifications.',
//           icon: '@mipmap/ic_launcher',
//         ),
//       ),
//       payload: jsonEncode(message.data),
//     );
//   }

//   Future<void> _handleMessage(RemoteMessage message) async {
//     // Handle the message by navigating to a specific page or processing the data
//     // print('Message data: $message');
//     navigatorKey.currentState?.pushNamed(
//       NotifikasiPage.route,
//       arguments: message,
//     );
//     final notification = NotificationItem.fromRemoteMessage(message);
//     await _notificationService.addNotification(notification);

//     // Mengirim data terbaru ke Stream
//     final updatedNotifications = await _notificationService.getNotifications();
//     _notificationStreamController.sink.add(updatedNotifications);
//   }

//   void initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final initialNotifications = await _notificationService.getNotifications();
//     _notificationStreamController.sink.add(initialNotifications);
//     await initPushNotifications();
//     await initLocalNotifications();
//   }
// }