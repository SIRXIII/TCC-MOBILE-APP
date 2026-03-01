import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class RefundRepository {
  static final RefundRepository instance = RefundRepository._internal();
  late ApiManager _apiManager;

  factory RefundRepository() {
    return instance;
  }

  RefundRepository._internal() {
    _apiManager = ApiManager();
  }

  Future<dynamic> createRefundRequest(dynamic body) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerCreateRefundRequest,
      isMultiPart: true,
      multiPartData: body,
    );
  }

  Future<dynamic> getRefundRequests(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerRefundRequests,
      data: data,
      method: APIMethod.get,
    );
  }
}
