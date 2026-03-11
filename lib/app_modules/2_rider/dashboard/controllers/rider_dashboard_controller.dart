import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/service/location_service.dart';

class RiderDashboardController extends GetxController {
  /// --> checkLocationPermission
  Future<void> checkLocationPermission() async {
    try {
      final status = await Permission.location.status;

      if (status == PermissionStatus.denied) {
        Get.toNamed(AppRoutes.locationPermission);
      } else {
        if (UserPreferences.instance.isLoggedIn()) {
          await LocationService.getCurrentLocationWithAddress();
        }

      }
      // return status.isGranted;
    } catch (e) {
      // return false;
    }
  }

  final RxInt currentTabIndex = 0.obs;

  final List<String> tabTitles = [
    'Deliveries',
    'Returns',
    'Support',
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
