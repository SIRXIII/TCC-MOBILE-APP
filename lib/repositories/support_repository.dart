import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class SupportRepository {
  static final SupportRepository instance = SupportRepository._internal();
  late ApiManager _apiManager;

  factory SupportRepository() {
    return instance;
  }

  SupportRepository._internal() {
    _apiManager = ApiManager();
  }

  Future<dynamic> submitSupportTicket(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(ApiConstant.supportTickets, data: data);
  }

  Future<dynamic> getSupportTickets(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.supportTickets,
      data: data,
      method: APIMethod.get,
    );
  }

  Future<dynamic> deleteAddress(Map<String, dynamic> data, String id) async {
    return await _apiManager.requestAPi(
      '${ApiConstant.deleteAddress}$id',
      data: data,
      method: APIMethod.delete,
    );
  }

  Future<dynamic> getSupportTicketsMessages(
    Map<String, dynamic> data,
    int ticketId,
  ) async {
    return await _apiManager.requestAPi(
      '${ApiConstant.supportTickets}/$ticketId/messages',
      data: data,
      method: APIMethod.get,
    );
  }

  Future<dynamic> addSupportTicketsMessage(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.supportTicketsMessages,
      data: data,
      // method: APIMethod.get,
    );
  }
}
