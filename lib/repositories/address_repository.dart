import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class AddressRepository {
  static final AddressRepository instance = AddressRepository._internal();
  late ApiManager _apiManager;

  factory AddressRepository() {
    return instance;
  }

  AddressRepository._internal() {
    _apiManager = ApiManager();
  }

  Future<dynamic> addAddress(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerAddress,
      data: data,
    );
  }

  Future<dynamic> deleteAddress(Map<String, dynamic> data, String id) async {
    return await _apiManager.requestAPi(
      '${ApiConstant.deleteAddress}$id',
      data: data,
      method: APIMethod.delete,
    );
  }

  Future<dynamic> getAddress(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerAddress,
      data: data,
      method: APIMethod.get,
    );
  }
}
