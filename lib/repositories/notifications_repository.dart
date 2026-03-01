import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class NotificationsRepository {
  static final NotificationsRepository instance =
      NotificationsRepository._internal();
  late ApiManager _apiManager;

  factory NotificationsRepository() {
    return instance;
  }

  NotificationsRepository._internal() {
    _apiManager = ApiManager();
  }

  Future<dynamic> getNotifications(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.notifications,
      data: data,
      method: APIMethod.get,
    );
  }

  Future<dynamic> readNotification(Map<String, dynamic> data, String id) async {
    return await _apiManager.requestAPi(
      '/notifications/$id/read',
      data: data,
      // method: APIMethod.get,
    );
  }
}
