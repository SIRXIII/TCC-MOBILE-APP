// controllers/notifications_controller.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/notifications/model/notifications_api_response.dart';
import 'package:travel_clothing_club_flutter/repositories/notifications_repository.dart';

import '../../../../utils/app_imports.dart' hide Notification;

class NotificationsController extends GetxController {
  /// --> PROPERTIES

  /// --> onInit
  @override
  void onInit() {
    super.onInit();
    getNotificationsApiRequest();
  }

  void markAsRead(String notificationId) {
    // final index = notifications.indexWhere((n) => n.id == notificationId);
    // if (index != -1) {
    //   notifications[index] = notifications[index].copyWith(isRead: true);
    // }
  }

  void markAsUnread(String notificationId) {
    // final index = notifications.indexWhere((n) => n.id == notificationId);
    // if (index != -1) {
    //   notifications[index] = notifications[index].copyWith(isRead: false);
    // }
  }

  void markAllAsRead() {
    // for (int i = 0; i < notifications.length; i++) {
    //   if (!notifications[i].isRead) {
    //     notifications[i] = notifications[i].copyWith(isRead: true);
    //   }
    // }
    // Get.snackbar(
    //   'Success',
    //   'All notifications marked as read',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }

  var selectedAddress = Notification();

  var getNotificationsApiRequestLoader = false.obs;
  final _notifications = <Notification>[].obs;

  RxList<Notification> get notificationsList => _notifications;

  set setNotificationsList(List<Notification> addressList) {
    _notifications.value = List.from(addressList);
  }

  List<Notification> get readNotifications => _notifications
      .where((n) => n.readAt != null && n.readAt!.isNotEmpty)
      .toList();

  List<Notification> get unReadNotifications => _notifications
      .where((n) => n.readAt == null || n.readAt!.isEmpty)
      .toList();

  Future<void> getNotificationsApiRequest() async {
    debugPrint('getNotificationsApiRequest --> ');

    getNotificationsApiRequestLoader(true);

    Map<String, dynamic> requestBody = {};

    var response = await NotificationsRepository.instance.getNotifications(
      requestBody,
    );

    final apiResponse = notificationsApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.notifications != null) {
        setNotificationsList = apiResponse.notifications ?? [];

        getNotificationsApiRequestLoader(false);
      } else {
        // appToastView(title: apiResponse.message.toString());
      }
      getNotificationsApiRequestLoader(false);
    }
    getNotificationsApiRequestLoader(false);
  }

  // var updateNotificationsReadApiRequestLoader = false.obs;

  Future<void> updateNotificationsReadApiRequest(String id) async {
    debugPrint('updateNotificationsReadApiRequest --> ');

    getNotificationsApiRequestLoader(true);

    Map<String, dynamic> requestBody = {};

    var response = await NotificationsRepository.instance.readNotification(
      requestBody,
      id,
    );

    final apiResponse = notificationsApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.notifications != null) {
        // setNotificationsList = apiResponse.notifications ?? [];
        await getNotificationsApiRequest();
        getNotificationsApiRequestLoader(false);
      } else {
        // appToastView(title: apiResponse.message.toString());
      }
      getNotificationsApiRequestLoader(false);
    }
    getNotificationsApiRequestLoader(false);
  }
}
