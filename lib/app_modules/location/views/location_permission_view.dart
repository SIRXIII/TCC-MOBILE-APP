import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_clothing_club_flutter/app_modules/location/controllers/location_controller.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';

class LocationPermissionView extends StatelessWidget {
  LocationPermissionView({super.key});
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Increased top spacing
              // Location Icon - Larger and centered
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 50,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                'Enable Location Services',
                style: GoogleFonts.robotoSerif(
                  fontSize: 24,
                  fontWeight: FontWeight.w600, // Made slightly bolder
                  height: 1.3,
                  letterSpacing: -0.03,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description - Multi-line text as per screenshot
              const Text(
                'Allow us to show you curated rentals\navailable in your area.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              Obx(
                () => !locationController.isLocationAvailable
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: locationController.isLocationAvailable
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text(locationController.currentLocation.value),
                          ],
                        ),
                      ),
              ),

              SizedBox(height: 20),
              Obx(
                () => locationController.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Continue',
                        onPressed: locationController.requestLocationPermission,
                        isEnabled: true,
                      ),
              ),

              const SizedBox(height: 12),

              // Enter Manually Button - Transparent background with border
              SizedBox(
                width: double.infinity,
                height: 56, // Same height as CustomButton
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.addManualLocationView);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Enter manually',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // LocationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _requestLocationPermission(BuildContext context) {
    // Implement location permission logic here
    print('Location permission requested');

    // After permission, navigate to next screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
  }
}

class LocationWidget extends StatelessWidget {
  LocationWidget({super.key});

  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          // Location Status
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: locationController.isLocationAvailable
                  ? Colors.green
                  : Colors.red,
            ),
            title: Text(locationController.currentLocation.value),
            subtitle: Text(
              locationController.isLocationAvailable
                  ? 'Location access granted'
                  : 'Location access required',
            ),
            trailing: locationController.isLoading.value
                ? const CircularProgressIndicator()
                : IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: locationController.checkLocationStatus,
                  ),
          ),

          // Request Permission Button (if not granted)
          if (!locationController.isLocationPermissionGranted.value)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: locationController.requestLocationPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Enable Location'),
                ),
              ),
            ),

          // Enable Location Services (if not enabled)
          if (!locationController.isLocationServiceEnabled.value &&
              locationController.isLocationPermissionGranted.value)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => locationController.requestLocationPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Enable Location Services'),
                ),
              ),
            ),
        ],
      );
    });
  }
}
