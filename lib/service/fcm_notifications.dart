import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// -----------------------------------
// Initialization
// -----------------------------------

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// -----------------------------------
// initMessaging
// -----------------------------------
Future<void> initMessaging() async {
  FirebaseMessaging.instance.requestPermission();
  // tz.initializeTimeZones();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: iosInitializationSettings,
    macOS: null,
  );

  await flutterLocalNotificationsPlugin
      .initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            forNotification, //selectNotification,
        onDidReceiveNotificationResponse: forNotification,
      )
      .then((_) {
        // debugPrint('setupPlugin: setup success');
      })
      .catchError((Object error) {
        // debugPrint('Error: $error');
      });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    showNotification(
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      message,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    // NotificationController.instance.getNotifications();

    var payload = message.data;
    if (payload.isNotEmpty) {
      if (payload['notification_type'] == '4') {
      } else if (payload['type'] == '3') {
      } else if (payload['type'] == '1') {
      } else if (payload['type'] == '5') {
      } else if (payload['type'] == '2') {
      } else if (payload['type'] == '9') {}
    }
  });
}

// -----------------------------------
// showNotification
// -----------------------------------
Future<void> showNotification(String title, String body, var message) async {
  ///RemoteMessage
  try {
    Random random = Random();
    int id = random.nextInt(1000);
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "TCC",
        "App",
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 50000,
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true,
        presentBadge: true,
        presentAlert: true,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body.contains('VoiceNotes')
          ? 'Send you a voice.'
          : body.contains('images')
          ? 'Send you a photo.'
          : body.contains("parameter=")
          ? body.contains('postShare')
                ? 'Shared a post with you.'
                : "Shared a business with you"
          : body.contains('http')
          ? 'Shared a file with you'
          : body,
      notificationDetails,
      payload: message == null ? '' : jsonEncode(message.data),
    );
  } on Exception catch (_) {
    // Error handled silently in production
  }
}

Future<void> showLocalNotification(
  String title,
  String body,
  NotificationPayload payload,
) async {
  try {
    Random random = Random();
    int id = random.nextInt(1000);
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "TCC",
        "App",
        importance: Importance.high,
        priority: Priority.high,
        // fullScreenIntent: true,
        playSound: true,
        timeoutAfter: 50000,
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true,
        presentBadge: true,
        presentAlert: true,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body.contains('VoiceNotes')
          ? 'Send you a voice.'
          : body.contains('images')
          ? 'Send you a photo.'
          : body.contains("parameter=")
          ? body.contains('postShare')
                ? 'Shared a post with you.'
                : "Shared a business with you"
          : body.contains('http')
          ? 'Shared a file with you'
          : body,
      notificationDetails,
      payload: jsonEncode(payload),
    );
  } on Exception catch (_) {
    // Error handled silently in production
  }
}

// -----------------------------------
// forNotification
// -----------------------------------
// 0 for like, 1 for comment, 2 for post, 3 for follower, 4 for chat
Future<void> forNotification(NotificationResponse notificationResponse) async {
  var payload = jsonDecode(notificationResponse.payload!);

  if (payload != null) {
    if (payload['notification_type'] == '4') {
    } else if (payload['type'] == '3') {
    } else if (payload['type'] == '1') {
    } else if (payload['type'] == '5') {
    } else if (payload['type'] == '2') {
    } else if (payload['type'] == '9') {}
  }
}

// -----------------------------------
// selectNotification
// -----------------------------------
Future<void> selectNotification(payload) async {
  // debugPrint('tap on notifications');

  if (payload != null) {
    if (payload['notification_type'] == '4') {
    } else if (payload['type'] == '3') {
    } else if (payload['type'] == '1') {
    } else if (payload['type'] == '5') {
    } else if (payload['type'] == '2') {
    } else if (payload['type'] == '9') {}
    // 0 for like, 1 for comment, 2 for post, 3 for follower, 4 for chat
  }
}

// -----------------------------------
// _firebaseMessagingBackgroundHandler
// -----------------------------------
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // debugPrint('payload ${message.data}');
  // NotificationController.instance.getNotifications();
}

class NotificationPayload {
  final String? title;
  final String? body;
  final String? screen;
  final Map<String, dynamic>? data;

  NotificationPayload({this.title, this.body, this.screen, this.data});

  /// Convert JSON string → Model
  factory NotificationPayload.fromJson(String jsonString) {
    try {
      final Map<String, dynamic> json = jsonDecode(jsonString);

      return NotificationPayload(
        title: json['title'],
        body: json['body'],
        screen: json['screen'],
        data: json['data'] != null
            ? Map<String, dynamic>.from(json['data'])
            : null,
      );
    } catch (e) {
      // In case payload is not JSON or malformed
      return NotificationPayload(body: jsonString);
    }
  }

  /// Convert model → JSON string
  String toJson() {
    final Map<String, dynamic> json = {
      'title': title,
      'body': body,
      'screen': screen,
      'data': data,
    };

    return jsonEncode(json);
  }
}
