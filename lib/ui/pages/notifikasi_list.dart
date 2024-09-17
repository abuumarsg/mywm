import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myWM/models/notifikasi_model.dart';
import 'package:myWM/notifikasi/notifikasi_service.dart';
import 'package:myWM/ui/pages/notifikasi_page.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../notifikasi/firebase_api.dart';
import '../../shared/share_methods.dart';
import '../../shared/theme.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});
  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  final NotificationService _notificationService = NotificationService();
  final FirebaseApi _firebaseApi = FirebaseApi();
  List<NotificationItem> _notifications = [];
  // int _unreadCount = 0;
  late StreamSubscription<NotificationItem> _notificationSubscription;


  @override
  void initState() {
    // logger.i('initState');
    super.initState();
    _loadNotifications();
    _subscribeToNotificationStream();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadNotifications();
    _subscribeToNotificationStream();
  }


  @override
  void dispose() {
    _notificationSubscription.cancel();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    // logger.i('_loadNotifications');
    await _notificationService.cleanExpiredNotifications();
    // final notificationsUnread = await _notificationService.getNotifications(unreadOnly: true);
    final notifications = await _notificationService.getNotifications();
    setState(() {
      _notifications = notifications;
      // _unreadCount = notificationsUnread.length;
    });
  }
  void _subscribeToNotificationStream() {
    _notificationSubscription = _firebaseApi.notificationStream.listen((notification) {
      setState(() {
        _notifications.insert(0, notification);
        // _unreadCount++;
      });
    });
  }
  Future<void> clearAllNotifications() async {
    showCustomSnackBarSuccess(context, 'Notifikasi Berhasil dihapus');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    Future.delayed(const Duration(seconds: 2), () {
      _loadNotifications();
    });
  }  

  @override
  Widget build(BuildContext context) {
    return PopScope (
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
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: whiteColor,
              ),
              onPressed: _loadNotifications,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: whiteColor,
              ),
              onPressed: clearAllNotifications,
            ),
          ],
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
          child: (_notifications.isNotEmpty) ? ListView.builder(
            itemCount: _notifications.length,
            itemBuilder: (context, index) {
              final notification = _notifications[index];
              return Container(
                margin: EdgeInsets.only(
                  left: 10.sp,
                  right: 10.sp,
                  top: 10.sp,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 17.sp,
                  vertical: 12.sp,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: blueColor, 
                    width: 1
                  ),
                ),
                child: GestureDetector(
                  onTap: () async {
                    await _notificationService.markAsRead(notification.id);
                    Navigator.pushNamed(
                      context,
                      NotifikasiPage.route,
                      arguments: RemoteMessage(
                        messageId: notification.id,
                        notification: RemoteNotification(
                          title: notification.title,
                          body: notification.body,
                        ),
                        sentTime: notification.timestamp,
                        data: notification.data,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            notification.isRead ? Icons.drafts : Icons.mark_email_unread,
                            color: notification.isRead ? Colors.grey : redColor,
                            size: 30.sp,
                          ),
                          SizedBox(width: 10.sp,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 16.sp),
                                child: SizedBox(
                                  width: 240.sp,
                                  child: Text(
                                    notification.title,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.sp,),
                              Padding(
                                padding: EdgeInsets.only(right: 16.sp),
                                child: SizedBox(
                                  width: 240.sp,
                                  child: Text(
                                    notification.body,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: regular,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.sp,),
                              Padding(
                                padding: EdgeInsets.only(right: 16.sp),
                                child: SizedBox(
                                  width: 240.sp,
                                  child: Text(
                                    DateFormat('dd/MM/yyyy HH:mm').format(notification.timestamp),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: regular,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ) : 
          ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: 10.sp,
                  right: 10.sp,
                  top: 10.sp,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 17.sp,
                  vertical: 12.sp,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                ),
                child: SizedBox(
                  height:50.sp, 
                  child: Center(
                    child: Text(
                      'Tidak ada Nottifikasi',
                      style: blackTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}