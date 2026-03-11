import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/traveler_orders_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/data/app_global.dart';
import 'package:travel_clothing_club_flutter/data/logged_in_user_data.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_constants.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_images.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/svg_icon_widget.dart';

class TravelerProfileView extends StatelessWidget {
  TravelerProfileView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthController authController = Get.find<AuthController>();

  // final loggedInUserData = UserPreferences.instance;
  final TravelerOrdersController controller = Get.put(
    TravelerOrdersController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            // Orders List
            _buildProfileBody(),
          ],
        ),
      ),
      key: _scaffoldKey,
    );
  }

  Widget _buildProfileBody() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Header
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: AppCacheImageView(
                          imageUrl:
                              authController.loggedInUserData.traveler
                                  ?.getProfilePhoto() ??
                              '',
                          width: 100,
                          height: 100,
                          isProfile: true,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    appTextView(
                      text:
                          authController.loggedInUserData.traveler?.getName() ??
                          '',
                      size: AppDimensions.FONT_SIZE_18,
                      fontFamily: 'Roboto',
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.w600,
                    ),

                    const SizedBox(height: 4),
                    appTextView(
                      text:
                          authController.loggedInUserData.traveler
                              ?.getEmail() ??
                          '',
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      color: AppColors.TEXT_2,
                      fontWeight: FontWeight.w400,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                        ),
                        icon: SvgIconWidget(
                          assetName: AppImages.icEdit,
                          size: 16,
                        ),
                        label: const Text(
                          "Edit profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.travelerEditProfile);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    width: Get.width,
                    child: appTextView(
                      text: 'Account Settings',
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      color: AppColors.TEXT_2,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                // Profile Options
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileOption(AppImages.icAddress, 'Address', () {
                      Get.toNamed(AppRoutes.addressList);
                    }),

                    // const SizedBox(height: 20),
                    // _buildProfileOption(
                    //   AppImages.icPayment,
                    //   'Payment Method',
                    //   () {},
                    // ),
                    const SizedBox(height: 20),
                    _buildProfileOption(
                      AppImages.icNotificationY,
                      'Notification',
                      () {
                        Get.toNamed(AppRoutes.travelerNotifications);
                      },
                    ),

                    authController.loggedInUserData.traveler
                                ?.isSocialLogged() ??
                            false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              _buildProfileOption(
                                AppImages.icSecurity,
                                'Account Security',
                                () {
                                  Get.toNamed(AppRoutes.changePassword);
                                  // appToastView(title: 'Coming Soon');
                                },
                              ),
                            ],
                          ),

                    // _buildProfileOption(Icons.payment, 'Payment Methods', () {
                    //   Get.snackbar(
                    //     'Payment Methods',
                    //     'Opening payment settings...',
                    //     snackPosition: SnackPosition.BOTTOM,
                    //   );
                    // }),
                    // _buildProfileOption(
                    //   Icons.notifications_outlined,
                    //   'Notifications',
                    //   () {
                    //     Get.snackbar(
                    //       'Notifications',
                    //       'Opening notification settings...',
                    //       snackPosition: SnackPosition.BOTTOM,
                    //     );
                    //   },
                    // ),
                    // _buildProfileOption(Icons.help_outline, 'Help & Support', () {
                    //   Get.snackbar(
                    //     'Help & Support',
                    //     'Opening support center...',
                    //     snackPosition: SnackPosition.BOTTOM,
                    //   );
                    // }),
                    // _buildProfileOption(Icons.settings_outlined, 'Settings', () {
                    //   Get.snackbar(
                    //     'Settings',
                    //     'Opening settings...',
                    //     snackPosition: SnackPosition.BOTTOM,
                    //   );
                    // }),
                    // _buildProfileOption(Icons.logout, 'Logout', () {
                    //   Get.offAllNamed('/onboarding');
                    // }, isLogout: true),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16),
                  child: SizedBox(
                    width: Get.width,
                    child: appTextView(
                      text: 'General',
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      color: AppColors.TEXT_2,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Divider(color: AppColors.TEXT_1.withValues(alpha: 0.5)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileOption(AppImages.icRefund, 'Refunds', () {
                      Get.toNamed(AppRoutes.refundRequests);
                    }),
                    const SizedBox(height: 20),
                    _buildProfileOption(
                      AppImages.icPrivacy,
                      'Privacy Policy',
                      () {
                        AppGlobal.instance.openLink(AppConstants.privacyPolicy);
                        // appToastView(title: 'Coming Soon');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        color: AppColors.TEXT_1.withValues(alpha: 0.5),
                      ),
                    ),

                    _buildProfileOption(AppImages.icHelp, 'FAQs', () {
                      AppGlobal.instance.openLink(AppConstants.urlFaq);
                    }),
                    const SizedBox(height: 20),
                    _buildProfileOption(AppImages.icLogout, 'Logout', () {
                      LoggedInUserData.instance.logoutConfirmationSheet(true);
                    }, isLogout: true),

                    InkWell(
                      onTap: () {
                        LoggedInUserData.instance
                            .deleteAccountConfirmationSheetView(true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Get.width,
                          child: appTextView(
                            text: "Delete Account",
                            underLine: TextDecoration.underline,
                            textAlign: TextAlign.center,
                            color: AppColors.RED,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.BLACK,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: 'Profile',
            color: AppColors.BLACK,
            size: AppDimensions.FONT_SIZE_18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            // isStroke: false,
          ),
        ],
      ),

      // leading: IconButton(
      //   icon: SvgIconWidget(assetName: AppImages.icDrawer, size: 36),
      //   onPressed: () {
      //     _scaffoldKey.currentState!.openDrawer();
      //     // Scaffold.of(context).openEndDrawer(); // Open the end drawer
      //   },
      // ),
    );
  }

  Widget _buildProfileStat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(title, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildProfileOption(
    String icon,
    String title,
    // String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgIconWidget(assetName: icon),
            ),
          ),
          const SizedBox(width: 12), // Spacing between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                appTextView(
                  text: title,
                  size: AppDimensions.FONT_SIZE_16,
                  fontFamily: 'Roboto',
                  color: isLogout ? AppColors.RED : AppColors.BLACK,
                  fontWeight: FontWeight.w500,
                ),
                // Optionally add a subtitle here
                // subtitle != null ? Text(subtitle) : SizedBox.shrink(),
              ],
            ),
          ),

          isLogout
              ? SizedBox.shrink()
              : const Icon(Icons.arrow_forward_ios, size: 16), // Trailing icon
        ],
      ),
    );
  }
}
