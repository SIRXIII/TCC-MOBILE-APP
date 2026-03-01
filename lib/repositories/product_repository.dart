import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class ProductRepository {
  static final ProductRepository instance = ProductRepository._internal();
  late ApiManager _apiManager;

  factory ProductRepository() {
    return instance;
  }

  ProductRepository._internal() {
    _apiManager = ApiManager();
  }

  Future<dynamic> travelerProducts(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerProducts,
      data: data,
    );
  }
}
