import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

class FiltersRepository {
  static final FiltersRepository instance = FiltersRepository._internal();
  late ApiManager _apiManager;

  factory FiltersRepository() {
    return instance;
  }

  FiltersRepository._internal() {
    _apiManager = ApiManager();
  }

  // --> travelerFiltersOptions
  Future<dynamic> travelerFiltersOptions(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerFilterOptions,
      data: data,
      method: APIMethod.get,
    );
  }
}
