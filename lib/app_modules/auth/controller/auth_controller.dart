import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/update_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/repository/auth_repository.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/controllers/account_type_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class AuthController extends GetxController {
  // -----------------------------------
  // INITIALIZE
  // -----------------------------------

  AuthController._privateConstructor();

  static AuthController get instance => _instance;

  static final AuthController _instance = AuthController._privateConstructor();

  factory AuthController() {
    return _instance;
  }

  var isLoading = false.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController heightInCmController = TextEditingController();
  TextEditingController chestInCmController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController changePasswordController = TextEditingController();
  TextEditingController changeNewPasswordController = TextEditingController();
  TextEditingController changeConfirmPasswordController =
      TextEditingController();

  // final LoggedInUserData loggedInUserData = LoggedInUserData.instance;

  // --> onInit
  @override
  void onInit() {
    // if (kDebugMode) {
    //   nameController.text = 'John';
    //   emailController.text = 'john@gmail.com';
    //   // 'john@rider.com';
    //   signupPasswordController.text = '11223344';
    //   confirmPasswordController.text = '11223344';
    //   passwordController.text = '11223344';
    // }

    super.onInit();
  }

  final Rx<UserData> _loggedInUserData = UserData().obs;

  UserData get loggedInUserData => _loggedInUserData.value;

  // -----------------------------------
  // registerUserApiRequest
  // -----------------------------------

  Future<void> travelerRegisterApiRequest() async {
    debugPrint('travelerRegisterApiRequest --> ');

    if (nameController.value.text.isEmpty) {
      appToastView(title: 'Please enter name');
      return;
    }
    if (emailController.text.isEmpty) {
      appToastView(title: 'Please enter email');
      return;
    }
    if (signupPasswordController.text.isEmpty) {
      appToastView(title: 'Please enter password');
      return;
    }
    isLoading(true);

    var response = await AuthRepository.instance.travelerRegister({
      'name': nameController.value.text.toString(),
      'email': emailController.text.toString(),
      'password': signupPasswordController.text.toString(),
      'password_confirmation': confirmPasswordController.text.toString(),
    });

    // var jsonData = await jsonDecode(response.toString());
    final authApiResponse = authApiResponseFromJson(response.toString());

    debugPrint('registerUserApiRequest --> ');

    if (response != null) {
      if (authApiResponse.success ?? false) {
        appToastView(title: authApiResponse.message.toString());

        _loggedInUserData.value = authApiResponse.data!;
        Get.toNamed(AppRoutes.login);
        // Get.toNamed(Routes.login);
        isLoading(false);
      } else {
        appToastView(
          title:
              authApiResponse.errors?.getAllErrors() ??
              authApiResponse.message.toString(),
        );
        // appToastView(title: authApiResponse.message.toString());
      }
      isLoading(false);
    }
    isLoading(false);
  }

  // -----------------------------------
  // Skip Registration
  // -----------------------------------

  // final guestData = GuestUserGenerator.generate();

  String generateRandomUniqueEmail() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);

    return 'guest_${timestamp}_$random@app.com';
  }

  Future<void> skipRegisterApiRequest() async {
    debugPrint('skipRegisterApiRequest --> ');

    isLoading(true);

    var email = generateRandomUniqueEmail();
    var response = await AuthRepository.instance.travelerRegister({
      'name': "Guest",
      'email': email,
      'password': 'Password@123.12',
      'password_confirmation': 'Password@123.12',
    });

    // var jsonData = await jsonDecode(response.toString());
    final authApiResponse = authApiResponseFromJson(response.toString());

    debugPrint('skipRegisterApiRequest --> ');

    final AccountTypeController controller = Get.find<AccountTypeController>();

    if (response != null) {
      if (authApiResponse.success ?? false) {
        // appToastView(title: authApiResponse.message.toString());

        _loggedInUserData.value = authApiResponse.data!;
        emailController.text = email;
        passwordController.text = 'Password@123.12';
        controller.selectAccountType(AccountTypeEnum.traveler);
        Future.delayed(const Duration(seconds: 200));

        await travelerLoginApiRequest();
        // Get.toNamed(AppRoutes.login);
        // Get.toNamed(Routes.login);
        isLoading(false);
      } else {
        appToastView(
          title:
              authApiResponse.errors?.getAllErrors() ??
              authApiResponse.message.toString(),
        );
        // appToastView(title: authApiResponse.message.toString());
      }
      isLoading(false);
    }
    isLoading(false);
  }

  // -----------------------------------
  // Login With Google
  // -----------------------------------
  var loginWithGoogleApiRequestLoader = false.obs;
  Future<void> loginWithGoogleApiRequest(String accessToken) async {
    debugPrint(
      'loginWithGoogleApiRequest --> ${UserPreferences.instance.selectedUserType}',
    );

    try {
      loginWithGoogleApiRequestLoader(true);
      var response = await AuthRepository.instance.loginWithGoogle({
        'access_token': accessToken,
        // 'device_token': deviceToken ?? '',
      });

      final authApiResponse = authApiResponseFromJson(response.toString());

      if (authApiResponse.success ?? false) {
        // if (authApiResponse.data?.stripeCustomerId == null) {
        //   StripePaymentController.instance.createCustomerApiRequest();
        // }

        await UserPreferences.instance.saveToken(
          authApiResponse.data!.getAuthToken(),
        );
        await UserPreferences.instance.saveUserSession(
          userData: authApiResponse.data!.toJson(),
        );

        if (UserPreferences.instance.selectedUserType ==
            AccountTypeEnum.traveler) {
          await Future.delayed(const Duration(seconds: 1));
          UserPreferences.instance.saveUserType(
            AccountTypeEnum.traveler.name.capitalizeFirst.toString(),
          );
          Get.offAllNamed(AppRoutes.travelerDashboard);
        } else {
          UserPreferences.instance.saveUserType(
            AccountTypeEnum.rider.name.capitalizeFirst.toString(),
          );
          await Future.delayed(const Duration(seconds: 1));
          Get.offAllNamed(AppRoutes.riderDashboard);
        }

        loginWithGoogleApiRequestLoader(false);
      } else {
        appToastView(title: authApiResponse.message.toString());
        loginWithGoogleApiRequestLoader(false);
      }
      loginWithGoogleApiRequestLoader(false);
    } catch (e) {
      AppLogger.debugPrintLogs(
        'loginWithGoogleApiRequestLoader - error',
        e.toString(),
      );
      loginWithGoogleApiRequestLoader(false);
    }
  }

  // -----------------------------------
  // travelerLoginApiRequest
  // -----------------------------------
  Future<void> travelerLoginApiRequest() async {
    debugPrint(
      'loginUserApiRequest --> ${UserPreferences.instance.selectedUserType}',
    );

    if (emailController.text.isEmpty) {
      appToastView(title: 'Please enter email');
      return;
    }
    if (passwordController.text.isEmpty) {
      appToastView(title: 'Please enter password');
      return;
    }
    isLoading(true);
    var response = await AuthRepository.instance.userLogIn({
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
      // 'device_token': deviceToken ?? '',
    });

    final authApiResponse = authApiResponseFromJson(response.toString());

    if (authApiResponse.success ?? false) {
      // if (authApiResponse.data?.stripeCustomerId == null) {
      //   StripePaymentController.instance.createCustomerApiRequest();
      // }

      await UserPreferences.instance.saveToken(
        authApiResponse.data!.getAuthToken(),
      );
      await UserPreferences.instance.saveUserSession(
        userData: authApiResponse.data!.toJson(),
      );

      if (UserPreferences.instance.selectedUserType ==
          AccountTypeEnum.traveler) {
        await Future.delayed(const Duration(seconds: 1));
        UserPreferences.instance.saveUserType(
          AccountTypeEnum.traveler.name.capitalizeFirst.toString(),
        );

        if (authApiResponse.data?.traveler?.getAddress() == '') {
          Get.toNamed(AppRoutes.locationPermission);
        } else if (authApiResponse.data?.traveler?.getSize() == '') {
          Get.offAllNamed(AppRoutes.profileSetup);
        } else {
          Get.offAllNamed(AppRoutes.travelerDashboard);
        }
        // Get.offAllNamed(AppRoutes.travelerDashboard);
      } else {
        UserPreferences.instance.saveUserType(
          AccountTypeEnum.rider.name.capitalizeFirst.toString(),
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.riderDashboard);
      }

      isLoading(false);
    } else {
      appToastView(title: authApiResponse.message.toString());
      isLoading(false);
    }
    isLoading(false);
  }

  // -----------------------------------
  // travelerForgotPasswordApiRequest
  // -----------------------------------
  var travelerForgotPasswordApiRequestLoading = false.obs;

  Future<void> travelerForgotPasswordApiRequest() async {
    debugPrint(
      'travelerForgotPasswordApiRequest --> ${UserPreferences.instance.selectedUserType}',
    );
    // var deviceToken = await FirebaseMessaging.instance.getToken();
    // debugPrint('...................$deviceToken');

    // if (deviceToken != '') {}
    // return;

    if (emailController.text.isEmpty) {
      appToastView(title: 'Please enter email');
      return;
    }

    travelerForgotPasswordApiRequestLoading(true);
    var response = await AuthRepository.instance.travelerForgotPassword({
      'email': emailController.text.toString(),
      // 'device_token': deviceToken ?? '',
    });

    final authApiResponse = authApiResponseFromJson(response.toString());

    if (authApiResponse.success ?? false) {
      // LoggedInUserData.instance.saveLoggedInUserData(authApiResponse.data!);

      // if (AppGlobal.instance.selectedAccountType == AccountTypeEnum.traveler) {
      //   Get.offAllNamed(AppRoutes.travelerDashboard);
      // } else {
      //   Get.offAllNamed(AppRoutes.riderDashboard);
      // }
      // if (LoggedInUserData.instance.getSelectedMode() == 'customer') {
      //   Get.offAllNamed(Routes.homeScreen);
      // } else {
      //   LoggedInUserData.instance.navigateToDriverHome();
      //   // Get.offAllNamed(Routes.driverZipCodeScreen);
      // }
      appToastView(title: authApiResponse.message.toString());
      travelerForgotPasswordApiRequestLoading(false);
    } else {
      appToastView(title: authApiResponse.message.toString());
      travelerForgotPasswordApiRequestLoading(false);
    }
    travelerForgotPasswordApiRequestLoading(false);
  }

  // -----------------------------------
  /// Update Location
  // -----------------------------------
  Future<void> updateLocationApiRequest(
    String country,
    String city,
    String postalCode,
    String latitude,
    String longitude,
    String address,
  ) async {
    debugPrint('updateLocationApiRequest --> ');

    if (postalCode == '') {
      postalCode = '51000';
    }
    isLoading(true);

    var response = await AuthRepository.instance.updateLocation({
      'country': country,
      'city': city,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      // 'device_token': deviceToken ?? '',
    });

    final authApiResponse = authApiResponseFromJson(response.toString());

    if (UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler) {
      Get.offAllNamed(AppRoutes.profileSetup);
      // Get.offAllNamed(AppRoutes.travelerDashboard);
    } else {
      if (Get.currentRoute != AppRoutes.riderDashboard) {
        Get.offAllNamed(AppRoutes.riderDashboard);
      }
      // Get.offAllNamed(AppRoutes.riderDashboard);
    }

    isLoading(false);
  }

  // --> profileApiRequest
  Future<void> profileApiRequest() async {
    debugPrint('profileApiRequest -->');

    // try {
    var response = await AuthRepository.instance.userProfile();

    final authApiResponse = authApiResponseFromJson(response.toString());

    if (authApiResponse.success ?? false) {
      await UserPreferences.instance.saveUserSession(
        userData: authApiResponse.data!.toJson(),
      );

      _loggedInUserData.value = authApiResponse.data!;
      updateProfile();
      // LoggedInUserData.instance.saveLoggedInUserData(authApiResponse.data!);
      // appToastView(title: authApiResponse.message.toString());
    } else {
      if (authApiResponse.message!.contains("Unauthenticated")) {
        UserPreferences.instance.clearStorageAndLogout();
      }
      // appToastView(title: authApiResponse.message.toString());
    }
    // } catch (e) {
    //   debugPrint('profileApiRequest --> error: $e');
    // }
  }

  // final RxBool isLoading = false.obs;
  final RxString selectedImagePath = ''.obs;

  /// --> profileApiRequest
  void updateProfile() {
    debugPrint('updateProfile -->');
    debugPrint(
      'updateProfile --> ${UserPreferences.instance.selectedUserType}',
    );

    if (UserPreferences.instance.selectedUserType?.name ==
        AccountTypeEnum.traveler.name) {
      nameController.value = TextEditingController(
        text: loggedInUserData.traveler!.getName(),
      );
      emailController = TextEditingController(
        text: loggedInUserData.traveler!.email,
      );

      setSelectedGender(loggedInUserData.traveler!.getGender());
      // profileController.setSelectedSize(
      //   userPreferences.loggedInUserData.traveler!.size ?? '',
      // );

      if (loggedInUserData.traveler!.phone != null) {
        phoneNumberController = TextEditingController(
          text: loggedInUserData.traveler!.phone,
        );
      }

      if (loggedInUserData.traveler?.profilePhoto != null) {
        setProfileImageUrl(loggedInUserData.traveler!.profilePhoto!);
      }

      if (selectedDate == null) {
        if (loggedInUserData.traveler!.dateOfBirth != null) {
          selectedDate = DateTime.parse(
            loggedInUserData.traveler!.dateOfBirth!,
          );

          setSelectedDOB(
            '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
          );
        } else {
          setSelectedDOB('DD/MM/YYYY');
        }
      } else {
        setSelectedDOB(
          '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
        );
      }

      if (loggedInUserData.traveler?.size != null) {
        setSelectedSize(loggedInUserData.traveler?.getSize() ?? '');
      }
    }
  }

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString imageUrl = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void setProfileImageUrl(String url) {
    imageUrl.value = url;
  }

  final _selectedGender = 'Male'.obs;

  String get selectedGenderValue => _selectedGender.value;

  void setSelectedGender(String value) {
    _selectedGender.value = value;
  }

  String getGenderValue() {
    if (selectedGenderValue == 'Male') {
      return 'male';
    } else if (selectedGenderValue == 'Female') {
      return 'female';
    } else {
      return 'other';
    }
  }

  final _selectedSize = ''.obs;
  String get selectedSizeValue => _selectedSize.value;

  void setSelectedSize(String value) {
    _selectedSize.value = value;
  }

  DateTime? selectedDate; //2000-03-20

  final _dobString = ''.obs;
  String get selectedDOB => _dobString.value;
  void setSelectedDOB(String value) {
    _dobString.value = value;
  }

  Future<void> updateProfileApiRequest() async {
    debugPrint('updateProfileApiRequest --> ');
    try {
      isLoading(true);

      // Create FormData
      final formData = dio.FormData.fromMap({
        'name': nameController.value.text.trim(),
        'gender': getGenderValue(),
        'size': selectedSizeValue,
        'date_of_birth': selectedDOB,
        'phone': phoneNumberController.text.toString(),
      });

      // Add profile image if selected
      if (selectedImage.value != null) {
        formData.files.add(
          MapEntry(
            'profile_photo',
            await dio.MultipartFile.fromFile(
              selectedImage.value!.path,
              filename: 'profile_image.jpg',
            ),
          ),
        );
      }

      // Call API
      final response = await AuthRepository.instance.updateProfile(formData);

      // Parse response (if JSON)
      final updateApiResponse = updateApiResponseFromJson(response);

      if (updateApiResponse.success == true) {
        UserPreferences.instance.loggedInUserData.traveler!.profilePhoto =
            updateApiResponse.data?.traveler?.profilePhoto ?? '';
        appToastView(title: updateApiResponse.message.toString());
        await profileApiRequest();
        Get.back();
        // Get.offAllNamed(AppRoutes.travelerDashboard);
      } else {
        appToastView(
          title:
              updateApiResponse.errors?.getAllErrors() ??
              updateApiResponse.message.toString(),
        );
      }
      debugPrint('Profile updated successfully: ${updateApiResponse.message}');
    } catch (e) {
      debugPrint('saveLicenseImagesApiRequest --> error: $e');
    } finally {
      isLoading(false);
    }
  }

  // -----------------------------------
  /// Update FCM Token
  // -----------------------------------
  Future<void> setupProfileApiRequest() async {
    debugPrint('setupProfileApiRequest --> ');
    debugPrint(
      'setupProfileApiRequest --> ${heightInCmController.text.toString()}',
    );
    debugPrint(
      'setupProfileApiRequest --> ${chestInCmController.text.toString()}',
    );

    if (heightInCmController.text.isEmpty) {
      appToastView(title: 'Height(cm) is required!');
      return;
    }
    if (chestInCmController.text.isEmpty) {
      appToastView(title: 'Chest(cm) is required!');
      return;
    }

    try {
      isLoading(true);

      // Create FormData
      final formData = dio.FormData.fromMap({
        // 'name': nameController.value.text.trim(),
        'gender': getGenderValue(),
        'size': selectedSizeValue,
        'height': heightInCmController.text.toString(),
        'chest': chestInCmController.text.toString(),
        // 'date_of_birth': selectedDOB,
        // 'phone': phoneNumberController.text.toString(),
      });

      // Add profile image if selected
      if (selectedImage.value != null) {
        formData.files.add(
          MapEntry(
            'profile_photo',
            await dio.MultipartFile.fromFile(
              selectedImage.value!.path,
              filename: 'profile_image.jpg',
            ),
          ),
        );
      }

      // Call API
      final response = await AuthRepository.instance.updateProfile(formData);

      // Parse response (if JSON)
      final updateApiResponse = updateApiResponseFromJson(response);

      if (updateApiResponse.success == true) {
        appToastView(title: updateApiResponse.message.toString());
        await profileApiRequest();
        // Get.back();
        Get.offAllNamed(AppRoutes.travelerDashboard);
      } else {
        appToastView(
          title:
              updateApiResponse.errors?.getAllErrors() ??
              updateApiResponse.message.toString(),
        );
      }
      debugPrint('Profile updated successfully: ${updateApiResponse.message}');
    } catch (e) {
      debugPrint('saveLicenseImagesApiRequest --> error: $e');
    } finally {
      isLoading(false);
    }
  }

  // -----------------------------------
  /// Update FCM Token
  // -----------------------------------
  Future<void> updateFcmTokenApiRequest() async {
    debugPrint('updateFcmTokenApiRequest --> ');

    var deviceToken = await FirebaseMessaging.instance.getToken();
    debugPrint('...................$deviceToken');

    var response = await AuthRepository.instance.updateFcmToken({
      'fcm_token': deviceToken ?? '',
    });

    final apiResponse = authApiResponseFromJson(response.toString());

    if (kDebugMode) {
      if (apiResponse.success ?? false) {
        // appToastView(title: apiResponse.message.toString());
      } else {
        appToastView(title: apiResponse.message.toString());
      }
    }
  }

  // -----------------------------------
  /// Change Password
  // -----------------------------------

  var changePasswordApiRequestLoader = false.obs;

  Future<void> changePasswordApiRequest() async {
    debugPrint('changePasswordApiRequest --> ');
    if (changePasswordController.text.isEmpty) {
      appToastView(title: 'Please enter current password');
      return;
    }

    if (changeNewPasswordController.text.isEmpty) {
      appToastView(title: 'Please enter new password');
      return;
    }

    if (changeConfirmPasswordController.text.isEmpty) {
      appToastView(title: 'Please enter confirm password');
      return;
    }

    if (changeNewPasswordController.text !=
        changeConfirmPasswordController.text) {
      appToastView(title: 'New password and confirm password does not match');
      return;
    }

    changePasswordApiRequestLoader(true);
    var response = await AuthRepository.instance.changeOrPassword({
      'current_password': changePasswordController.text.toString(),
      'new_password': changeNewPasswordController.text.toString(),
      'new_password_confirmation': changeConfirmPasswordController.text
          .toString(),
    });

    final apiResponse = authApiResponseFromJson(response.toString());

    if (apiResponse.success ?? false) {
      appToastView(title: apiResponse.message.toString());
    } else {
      appToastView(
        title:
            apiResponse.errors?.getAllErrors() ??
            apiResponse.message.toString(),
      );
    }

    changePasswordApiRequestLoader(false);
  }

  void resetChangePasswordFields() {
    changePasswordController.clear();
    changeNewPasswordController.clear();
    changeConfirmPasswordController.clear();
  }
}
