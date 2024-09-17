import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

// import '../../models/notifikasi_model.dart';
// import '../../notifikasi/notifikasi_service.dart';
import '../../shared/theme.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});
  static const String route = '/notifikasi';

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

var logger = Logger();
class _NotifikasiPageState extends State<NotifikasiPage> {
  
  @override
  Widget build(BuildContext context) {
    final RemoteMessage? message = ModalRoute.of(context)?.settings.arguments as RemoteMessage?;
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blueBackgroundColor,
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Notifikasi',
            style: whiteTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: blueBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${message?.notification?.body}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// Future<void> showNotification() async {
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails('your channel id', 'your channel name',
//           channelDescription: 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker');
//   const NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Notifikasi Langsung', 'Ini adalah notifikasi langsung', notificationDetails,
//       payload: 'item x');
// }