// controllers/location_controller.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_clothing_club_flutter/service/location_service.dart';

class LocationController extends GetxController {
  final RxBool isLocationPermissionGranted = false.obs;
  final RxBool isLocationServiceEnabled = false.obs;
  final RxString currentLocation = 'Fetching location...'.obs;
  final RxString country = 'Unknown'.obs;
  final RxString city = 'Unknown'.obs;
  final RxString postalCode = 'Unknown'.obs;
  final RxString fullAddress = 'Unknown'.obs;
  final RxBool isLoading = false.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkLocationStatus();
  }

  // Check location status and get address
  Future<void> checkLocationStatus() async {
    isLoading.value = true;

    try {
      final status = await LocationService.isLocationPermissionGranted();
      isLocationPermissionGranted.value = status;
      isLocationServiceEnabled.value =
          await Geolocator.isLocationServiceEnabled();

      if (isLocationPermissionGranted.value && isLocationServiceEnabled.value) {
        await getCurrentLocationWithAddress();
      } else {
        currentLocation.value = 'Location access required';
        resetAddressDetails();
      }
    } catch (e) {
      currentLocation.value = 'Error checking location';
      resetAddressDetails();
      print('Error checking location status: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get current location with full address details
  Future<void> getCurrentLocationWithAddress() async {
    isLoading.value = true;

    try {
      await LocationService.getCurrentLocationWithAddress();

      // if (locationData != null) {
      //   latitude.value = locationData['latitude'] ?? 0.0;
      //   longitude.value = locationData['longitude'] ?? 0.0;
      //   country.value = locationData['country'] ?? 'Unknown';
      //   city.value = locationData['city'] ?? 'Unknown';
      //   postalCode.value = locationData['postalCode'] ?? 'Unknown';
      //   fullAddress.value = locationData['fullAddress'] ?? 'Unknown';
      //
      //   currentLocation.value = '${city.value}, ${country.value}';
      //   debugPrint('getCurrentLocationWithAddress: ${country.value}');
      //   debugPrint('getCurrentLocationWithAddress: ${city.value}');
      //   debugPrint('getCurrentLocationWithAddress: ${postalCode.value}');
      //
      //   AuthController.instance.updateLocationApiRequest(
      //     country.value.toString(),
      //     city.value.toString(),
      //     postalCode.value.toString(),
      //   );
      // } else {
      //   currentLocation.value = 'Unable to get location';
      //   resetAddressDetails();
      // }
    } catch (e) {
      currentLocation.value = 'Error getting location';
      resetAddressDetails();
      print('Error getting current location with address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Reset address details
  void resetAddressDetails() {
    country.value = 'Unknown';
    city.value = 'Unknown';
    postalCode.value = 'Unknown';
    fullAddress.value = 'Unknown';
    latitude.value = 0.0;
    longitude.value = 0.0;
  }

  // Get address from coordinates
  Future<void> getAddressFromCoordinates(double lat, double lng) async {
    isLoading.value = true;

    try {
      final addressData = await LocationService.getAddressFromCoordinates(
        lat,
        lng,
      );

      if (addressData != null) {
        country.value = addressData['country'] ?? 'Unknown';
        city.value = addressData['city'] ?? 'Unknown';
        postalCode.value = addressData['postalCode'] ?? 'Unknown';
        fullAddress.value = addressData['fullAddress'] ?? 'Unknown';
        latitude.value = lat;
        longitude.value = lng;

        currentLocation.value = '${city.value}, ${country.value}';
      }
    } catch (e) {
      print('Error getting address from coordinates: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get coordinates from address string
  Future<void> getCoordinatesFromAddress(String address) async {
    isLoading.value = true;

    try {
      final locationData = await LocationService.getCoordinatesFromAddress(
        address,
      );

      if (locationData != null) {
        latitude.value = locationData['latitude'] ?? 0.0;
        longitude.value = locationData['longitude'] ?? 0.0;
        country.value = locationData['country'] ?? 'Unknown';
        city.value = locationData['city'] ?? 'Unknown';
        postalCode.value = locationData['postalCode'] ?? 'Unknown';
        fullAddress.value = locationData['fullAddress'] ?? 'Unknown';

        currentLocation.value = '${city.value}, ${country.value}';
      }
    } catch (e) {
      print('Error getting coordinates from address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Request location permission
  Future<void> requestLocationPermission() async {
    isLoading.value = true;

    try {
      final status = await Permission.location.request();

      if (status.isGranted) {
        isLocationPermissionGranted.value = true;
        await getCurrentLocationWithAddress();
      } else if (status.isPermanentlyDenied) {
        currentLocation.value =
            'Permission permanently denied. Please enable in settings.';
        _showPermissionSettingsDialog();
      } else {
        currentLocation.value = 'Location permission denied';
      }
    } catch (e) {
      currentLocation.value = 'Error requesting permission';
      print('Error requesting location permission: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _showPermissionSettingsDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'Location permission is permanently denied. '
          'Please enable it in app settings to use location features.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  // Get complete location data
  Map<String, dynamic> get locationData {
    return {
      'country': country.value,
      'city': city.value,
      'postalCode': postalCode.value,
      'fullAddress': fullAddress.value,
      'latitude': latitude.value,
      'longitude': longitude.value,
      'currentLocation': currentLocation.value,
    };
  }

  // Check if location is available
  bool get isLocationAvailable {
    return isLocationPermissionGranted.value && isLocationServiceEnabled.value;
  }

  // Check if we have valid address data
  bool get hasValidAddress {
    return country.value != 'Unknown' &&
        city.value != 'Unknown' &&
        postalCode.value != 'Unknown';
  }
}
