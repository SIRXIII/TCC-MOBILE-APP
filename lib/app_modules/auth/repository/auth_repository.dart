import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_constants.dart';
import 'package:travel_clothing_club_flutter/data/data_source/api_manager.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  late ApiManager _apiManager;

  factory AuthRepository() {
    return instance;
  }

  AuthRepository._internal() {
    _apiManager = ApiManager();
  }

  Future<dynamic> loginWithGoogle(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerLoginWithGoogle
          : ApiConstant.riderLoginWithGoogle,
      data: data,
    );
  }

  Future<dynamic> travelerRegister(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      ApiConstant.travelerRegister,
      data: data,
    );
  }

  Future<dynamic> userLogIn(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.rider
          ? ApiConstant.riderLogin
          : ApiConstant.travelerLogin,
      data: data,
    );
  }

  // Future<dynamic> riderLogin(Map<String, String> data) async {
  //   return await _apiManager.requestAPi(ApiConstant.riderLogin, data: data);
  // }

  Future<dynamic> travelerForgotPassword(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerForgotPassword
          : ApiConstant.riderForgotPassword,
      data: data,
    );
  }

  Future<dynamic> updateProfile(dynamic body) async {
    return await _apiManager.requestAPi(
      ApiConstant.updateProfile,
      isMultiPart: true,
      multiPartData: body,
    );
  }

  Future<dynamic> travelerLogout(Map<String, String> data) async {
    return await _apiManager.requestAPi(ApiConstant.travelerLogout, data: data);
  }

  Future<dynamic> riderLogout(Map<String, String> data) async {
    return await _apiManager.requestAPi(ApiConstant.riderLogout, data: data);
  }

  Future<dynamic> updateLocation(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerUpdateLocation
          : ApiConstant.riderUpdateLocation,
      data: data,
    );
  }

  Future<dynamic> userProfile() async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerProfile
          : ApiConstant.riderProfile,
      method: APIMethod.get,
    );
  }

  Future<dynamic> updateFcmToken(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerUpdateFcmToken
          : ApiConstant.riderUpdateFcmToken,
      data: data,
    );
  }

  Future<dynamic> changeOrPassword(Map<String, String> data) async {
    return await _apiManager.requestAPi(
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
          ? ApiConstant.travelerUpdatePassword
          : ApiConstant.riderUpdatePassword,
      data: data,
    );
  }
}
