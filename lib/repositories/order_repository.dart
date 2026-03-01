import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class OrderRepository {
  static final OrderRepository instance = OrderRepository._internal();
  late ApiManager _apiManager;

  factory OrderRepository() {
    return instance;
  }

  OrderRepository._internal() {
    _apiManager = ApiManager();
  }

  // --> placeOrder
  Future<dynamic> placeOrder(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.placeOrder,
      data: data,
      // method: APIMethod.get,
    );
  }

  // --> placeOrder
  Future<dynamic> requestReturn(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerRequestReturn,
      data: data,
      // method: APIMethod.get,
    );
  }

  // --> Get Orders
  Future<dynamic> getOrders(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.ordersList,
      data: data,
      method: APIMethod.get,
    );
  }
}
