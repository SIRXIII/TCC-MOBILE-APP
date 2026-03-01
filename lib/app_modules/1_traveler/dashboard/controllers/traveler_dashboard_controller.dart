import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';

class TravelerDashboardController extends GetxController {
  final UserPreferences userPreferences = UserPreferences.instance;

  Future<void> checkLocationPermission() async {
    debugPrint('Checking location permission...');
    try {
      final status = await Permission.location.status;
      debugPrint('Checking location permission... $status');

      // Get.toNamed(AppRoutes.locationPermission);
      if (status == PermissionStatus.denied) {
        if (userPreferences.selectedUserType == AccountTypeEnum.traveler) {
          if (userPreferences.loggedInUserData.traveler?.getAddress() == '') {
            Get.toNamed(AppRoutes.locationPermission);
          }
        }
        // Get.toNamed(AppRoutes.locationPermission);
      } else {
        debugPrint('Location permission already granted');
      }
      // return status.isGranted;
    } catch (e) {
      debugPrint('Error checking location permission: $e');
      // return false;
    }
  }

  final RxInt currentTabIndex = 0.obs;

  final List<String> tabTitles = [
    'Home',
    'Browse',
    'Orders',
    'Cart',
    'Profile',
  ];

  void changeTabIndex(int index) {
    currentTabIndex.value = index;
  }

  // Sample data for demonstration
  final RxList<String> cartItems = <String>[].obs;
  final RxList<Map<String, String>> orders = <Map<String, String>>[
    {'id': '1', 'status': 'Completed', 'date': '2024-01-15'},
    {'id': '2', 'status': 'Pending', 'date': '2024-01-16'},
  ].obs;

  void addToCart(String item) {
    cartItems.add(item);
    Get.snackbar(
      'Added to Cart',
      '$item has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeFromCart(int index) {
    final removedItem = cartItems.removeAt(index);
    Get.snackbar(
      'Removed from Cart',
      '$removedItem has been removed from your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
