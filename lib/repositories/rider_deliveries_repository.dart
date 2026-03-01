import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class RiderDeliveriesRepository {
  static final RiderDeliveriesRepository instance =
      RiderDeliveriesRepository._internal();
  late ApiManager _apiManager;

  factory RiderDeliveriesRepository() {
    return instance;
  }

  RiderDeliveriesRepository._internal() {
    _apiManager = ApiManager();
  }

  // --> getDeliveries
  Future<dynamic> getDeliveries(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.riderOrdersList,
      data: data,
      method: APIMethod.get,
    );
  }

  // --> getDeliveries
  Future<dynamic> updateDeliveryStatusByOrderId(
    Map<String, dynamic> data,
  ) async {
    return await _apiManager.requestAPi(
      ApiConstant.riderUpdateOrderStatus,
      data: data,
      method: APIMethod.post,
    );
  }
}
