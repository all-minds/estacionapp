import 'package:estacionapp/services/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  final instance = FirebaseMessaging.instance;
  final user = FirebaseAuthService.getUser();

  FirebaseMessagingService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupAndroidDetails();
    _setupNotifications();
  }

  Future<void> initializeMessaging() async {
    await instance.subscribeToTopic('parking-general');

    final settings = await instance.requestPermission(
        alert: true, badge: true, provisional: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _onMessage();
    }
  }

  Future<void> unsubscribe() async {
    await instance.unsubscribeFromTopic('parking-general');
    await instance.unsubscribeFromTopic(user!.uid);
  }

  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_details',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes!',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
  }

  _setupNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;

      if (notification != null && android != null) {
        localNotificationsPlugin.show(android.hashCode, notification.title,
            notification.body, NotificationDetails(android: androidDetails));
      }

      // Notification(event: event).dispatch(target)
    });
  }
}
