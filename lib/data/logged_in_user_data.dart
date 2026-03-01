import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/repository/auth_repository.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class LoggedInUserData extends GetxController {
  // -----------------------------------
  // INITIALIZE
  // -----------------------------------
  LoggedInUserData._privateConstructor();

  static LoggedInUserData get instance => _instance;

  static final LoggedInUserData _instance =
      LoggedInUserData._privateConstructor();

  factory LoggedInUserData() {
    return _instance;
  }

  // final token = RxnString();

  // Save token
  // void saveToken(String newToken) {
  //   token.value = newToken;
  //   storageBox.write(StorageConstants.userToken, newToken);
  //
  //   debugPrint('newToken --> $newToken');
  // }

  // Load token (e.g., on startup)
  // void loadToken() {
  //   final storedToken = storageBox.read(StorageConstants.userToken);
  //   if (storedToken != null) {
  //     token.value = storedToken;
  //   }
  // }

  // final Rx<UserData> _loggedInUserData = UserData().obs;
  // -----------------------------------
  // saveLoggedInUserData
  // -----------------------------------
  // void saveLoggedInUserData(UserData userData) {
  //   debugPrint('saveLoggedInUserData --> ');
  //   _loggedInUserData.value = userData;
  //   storageBox.write(
  //     StorageConstants.loggedInUserData,
  //     _loggedInUserData.value.toJson(),
  //   );
  //   getLoggedInUserData();
  // }

  // -----------------------------------
  // getLoggedInUserData
  // -----------------------------------

  // UserData get loggedInUserData => _loggedInUserData.value;

  // void getLoggedInUserData() {
  //   Map<String, dynamic>? userData = storageBox.read(
  //     StorageConstants.loggedInUserData,
  //   );
  //   debugPrint('getLoggedInUserData --> ${userData}');
  //
  //   if (userData != null) {
  //     try {
  //       // retrievedUserData = UserData.fromJson(userData);
  //       _loggedInUserData.value = UserData.fromJson(userData);
  //       loadToken();
  //       AppGlobal.instance.loadLoggedInUserType();
  //       debugPrint('getLoggedInUserData --> token --> $token');
  //     } catch (e) {
  //       // LoggedInUserData.instance.clearStorageAndLogout();
  //       debugPrint('getLoggedInUserData e --> ${e.toString()}');
  //     }
  //   }
  // }

  // --> clearStorageAndLogout
  // Future<void> clearStorageAndLogout() async {
  //   debugPrint('clearStorageAndLogout -->');
  //   // storageBox.remove(StorageConstants.loggedInUserData);
  //   // storageBox.erase();
  //   await UserPreferences.instance.clearUserData();
  //   Future.delayed(const Duration(milliseconds: 200), () {
  //     Get.offAllNamed(AppRoutes.onboarding);
  //   });
  // }

  void logoutConfirmationSheet(bool isTraveler) {
    debugPrint(
      'logoutConfirmationSheet --> ${UserPreferences.instance.selectedUserType}',
    );
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, size: 40, color: Colors.red),
              ),
              const SizedBox(height: 20),

              appTextView(
                text: 'Logout?',
                size: AppDimensions.FONT_SIZE_22,
                fontFamily: 'Roboto',
                color: AppColors.BLACK,
                fontWeight: FontWeight.bold,
              ),
              // Title
              // const Text(
              //   'Logout?',
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 12),

              // Description
              appTextView(
                text: 'Are you sure you want to logout from your Account?',
                size: AppDimensions.FONT_SIZE_16,
                fontFamily: 'Roboto',
                color: AppColors.TEXT_1,
                textAlign: TextAlign.center,
                // fontWeight: FontWeight.bold,
              ),

              const SizedBox(height: 30),

              Obx(() {
                return logoutApiRequestLoader.isTrue
                    ? appLoaderView()
                    : Row(
                        children: [
                          // Cancel Button
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                side: BorderSide(
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Logout Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Get.back();
                                logoutApiRequest(isTraveler);
                                // _performLogout();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.PRIMARY_COLOR,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              }),

              // Buttons
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // --> logoutApiRequest
  var logoutApiRequestLoader = false.obs;

  Future<void> logoutApiRequest(bool isTraveler) async {
    debugPrint('logoutApiRequest --> ');

    logoutApiRequestLoader(true);
    var response = isTraveler
        ? await AuthRepository.instance.travelerLogout({'': ''})
        : await AuthRepository.instance.riderLogout({'': ''});

    final authApiResponse = authApiResponseFromJson(response.toString());

    if (authApiResponse.success ?? false) {
      UserPreferences.instance.clearStorageAndLogout();
      logoutApiRequestLoader(false);
    } else {
      appToastView(title: authApiResponse.message.toString());
      logoutApiRequestLoader(false);
    }
    logoutApiRequestLoader(false);
  }

  // --> Traveler Product Data
  final Rx<Product> _selectedProduct = Product().obs;

  Product get getSelectedProduct => _selectedProduct.value;

  set setSelectedProduct(Product data) {
    _selectedProduct.value = data;
  }

  /// --> Delete Account
  void deleteAccountConfirmationSheetView(bool isTraveler) {
    debugPrint(
      'deleteAccountConfirmationSheetView --> ${UserPreferences.instance.selectedUserType}',
    );
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete, size: 40, color: Colors.red),
              ),
              const SizedBox(height: 20),

              appTextView(
                text: 'Delete Account?',
                size: AppDimensions.FONT_SIZE_22,
                fontFamily: 'Roboto',
                color: AppColors.BLACK,
                fontWeight: FontWeight.bold,
              ),
              // Title
              // const Text(
              //   'Logout?',
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 12),

              // Description
              appTextView(
                text: 'Are you sure you want to Delete your Account?',
                size: AppDimensions.FONT_SIZE_16,
                fontFamily: 'Roboto',
                color: AppColors.TEXT_1,
                textAlign: TextAlign.center,
                // fontWeight: FontWeight.bold,
              ),

              const SizedBox(height: 30),

              Obx(() {
                return logoutApiRequestLoader.isTrue
                    ? appLoaderView()
                    : Row(
                        children: [
                          // Cancel Button
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                side: BorderSide(
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Logout Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Get.back();
                                logoutApiRequest(isTraveler);
                                // _performLogout();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.PRIMARY_COLOR,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              }),

              const SizedBox(height: 12),
              // Buttons
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
