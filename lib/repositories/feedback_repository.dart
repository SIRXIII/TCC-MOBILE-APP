import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';

import '../data/user_preferences.dart';

class FeedbackRepository {
  static final FeedbackRepository instance = FeedbackRepository._internal();
  late ApiManager _apiManager;

  factory FeedbackRepository() {
    return instance;
  }

  FeedbackRepository._internal() {
    _apiManager = ApiManager();
  }

  // --> rateOrder
  Future<dynamic> rateOrder(Map<String, dynamic> data, String orderId) async {
    return await _apiManager.requestAPi(
      '/traveler/orders/$orderId/rate',
      data: data,
      method: APIMethod.post,
    );
  }

  Future<dynamic> travelerToRiderRating(Map<String, dynamic> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerToRiderRating
          : ApiConstant.riderToTravelerRating,
      data: data,
      method: APIMethod.post,
    );
  }
}
