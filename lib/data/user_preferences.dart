import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';

class UserPreferences extends GetxController {
  // 🔒 Private constructor for singleton
  UserPreferences._privateConstructor();

  // 🔁 Single instance available globally
  static final UserPreferences instance = UserPreferences._privateConstructor();

  SharedPreferences? _prefs;

  @override
  void onInit() {
    super.onInit();

    init();
  }

  final _token = ''.obs;
  String get token => _token.value;

  final Rx<AccountTypeEnum?> _selectedAccountType = Rx<AccountTypeEnum?>(null);

  // Getter for selectedAccountType
  AccountTypeEnum? get selectedUserType => _selectedAccountType.value;

  // 🔑 Keys for storage
  static const String _keyUserData = 'user_data';
  static const String _keyToken = 'auth_token';
  static const String _keyUserType = 'user_type';

  // ✅ Initialize SharedPreferences once
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ✅ Save both user data
  Future<void> saveUserSession({
    required Map<String, dynamic> userData,
    // required String token,
  }) async {
    await _prefs?.setString(_keyUserData, jsonEncode(userData));
  }

  // ✅ Save token only
  Future<void> saveToken(String token) async {
    await _prefs?.setString(_keyToken, token);
    _token.value = token;
  }

  // ✅ Get token
  String? getToken() {
    _token.value = _prefs?.getString(_keyToken) ?? '';
    return _prefs?.getString(_keyToken);
  }

  // ✅ saveUserType
  Future<void> saveUserType(String userType) async {
    await _prefs?.setString(_keyUserType, userType);

    if (userType == 'Traveler') {
      _selectedAccountType.value = AccountTypeEnum.traveler;
    } else if (userType == 'Rider') {
      _selectedAccountType.value = AccountTypeEnum.rider;
    }
    // _selectedAccountType.value = userType;
  }

  // ✅ getUserType
  String? getUserType() {
    return _prefs?.getString(_keyUserType);
  }

  UserData? getUserData() {
    final data = _prefs?.getString(_keyUserData);
    if (data != null && data.isNotEmpty) {
      final Map<String, dynamic> jsonMap = jsonDecode(data);
      return UserData.fromJson(jsonMap);
    }
    return null;
  }

  // ✅ Check login state
  bool isLoggedIn() {
    final token = _prefs?.getString(_keyToken);
    AppLogger.debugPrintLogs('token', token);
    return token != null && token.isNotEmpty;
  }

  // ✅ Clear session (logout)
  Future<void> clearUserData() async {
    await _prefs?.remove(_keyUserData);
    await _prefs?.remove(_keyToken);
    await _prefs?.clear();
  }

  // ✅ Logged in User Data
  final Rx<UserData> _loggedInUserData = UserData().obs;
  UserData get loggedInUserData => _loggedInUserData.value;

  void getLoggedInUserData() {
    _loggedInUserData.value = getUserData() ?? UserData();
    getToken();

    if (getUserType() == 'Traveler') {
      _selectedAccountType.value = AccountTypeEnum.traveler;
    } else if (getUserType() == 'Rider') {
      _selectedAccountType.value = AccountTypeEnum.rider;
    }
  }

  // ✅ clearStorageAndLogout
  Future<void> clearStorageAndLogout() async {
    await FirebaseAuth.instance.signOut();
    await clearUserData();
    Future.delayed(const Duration(milliseconds: 200), () {
      Get.offAllNamed(AppRoutes.onboarding);
    });
  }
}
