// services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';

class LocationService {
  // Check if location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  // Get current location with address details
  static Future getCurrentLocationWithAddress() async {
    try {
      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check location permission
      PermissionStatus permission = await Permission.location.status;
      if (permission.isDenied) {
        permission = await Permission.location.request();
        if (permission.isDenied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission.isPermanentlyDenied) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        // var locationData =  {
        //   'latitude': position.latitude,
        //   'longitude': position.longitude,
        //   'country': placemark.country ?? 'Unknown',
        //   'city': _getCity(placemark),
        //   'postalCode': placemark.postalCode ?? 'Unknown',
        //   'street': placemark.street ?? 'Unknown',
        //   'subLocality': placemark.subLocality,
        //   'administrativeArea': placemark.administrativeArea,
        //   'subAdministrativeArea': placemark.subAdministrativeArea,
        //   'isoCountryCode': placemark.isoCountryCode,
        //   'fullAddress': _getFullAddress(placemark),
        // };

        AuthController.instance.updateLocationApiRequest(
          placemark.country ?? 'Unknown',
          _getCity(placemark),
          placemark.postalCode ?? 'Unknown',
          position.latitude.toString(),
          position.longitude.toString(),
          _getFullAddress(placemark),
        );

        UserPreferences.instance.loggedInUserData.rider?.setLocation(
          _getFullAddress(placemark),
        );

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
      } else {
        throw Exception('No address found for the coordinates');
      }
    } catch (e) {
      print('Error getting location with address: $e');
      return null;
    }
  }

  // Helper method to get city name (prioritizes locality, then subAdministrativeArea)
  static String _getCity(Placemark placemark) {
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      return placemark.locality!;
    } else if (placemark.subAdministrativeArea != null &&
        placemark.subAdministrativeArea!.isNotEmpty) {
      return placemark.subAdministrativeArea!;
    } else if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      return placemark.administrativeArea!;
    }
    return 'Unknown';
  }

  // Helper method to get full address
  static String _getFullAddress(Placemark placemark) {
    List<String> addressParts = [];

    if (placemark.street != null && placemark.street!.isNotEmpty) {
      addressParts.add(placemark.street!);
    }
    if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
      addressParts.add(placemark.subLocality!);
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.postalCode != null && placemark.postalCode!.isNotEmpty) {
      addressParts.add(placemark.postalCode!);
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      addressParts.add(placemark.country!);
    }

    return addressParts.join(', ');
  }

  // Get address from coordinates
  static Future<Map<String, dynamic>?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        return {
          'country': placemark.country ?? 'Unknown',
          'city': _getCity(placemark),
          'postalCode': placemark.postalCode ?? 'Unknown',
          'street': placemark.street ?? 'Unknown',
          'fullAddress': _getFullAddress(placemark),
        };
      }
      return null;
    } catch (e) {
      print('Error getting address from coordinates: $e');
      return null;
    }
  }

  // Get coordinates from address (geocoding)
  static Future<Map<String, dynamic>?> getCoordinatesFromAddress(
    String address,
  ) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations.first;

        // Get placemark for additional address details
        List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        Placemark placemark = placemarks.isNotEmpty
            ? placemarks.first
            : Placemark();

        return {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'country': placemark.country ?? 'Unknown',
          'city': _getCity(placemark),
          'postalCode': placemark.postalCode ?? 'Unknown',
          'street': placemark.street ?? 'Unknown',
          'fullAddress': _getFullAddress(placemark),
        };
      }
      return null;
    } catch (e) {
      print('Error getting coordinates from address: $e');
      return null;
    }
  }
}
