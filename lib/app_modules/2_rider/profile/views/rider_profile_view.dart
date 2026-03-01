import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/traveler_orders_controller.dart';

export 'package:flutter/material.dart';

import '../../../../utils/app_imports.dart';

class RiderProfileView extends StatelessWidget {
  RiderProfileView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final loggedInUserData = UserPreferences.instance;
  final TravelerOrdersController controller = Get.put(
    TravelerOrdersController(),
  );

  // --> build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // appBar: _buildAppBar(),
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

  // --> _buildProfileBody
  Widget _buildProfileBody() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Padding(
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
                            loggedInUserData.loggedInUserData.rider
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
                        loggedInUserData.loggedInUserData.rider?.getName() ??
                        '',
                    size: AppDimensions.FONT_SIZE_18,
                    fontFamily: 'Roboto',
                    color: AppColors.BLACK,
                    fontWeight: FontWeight.w600,
                  ),

                  const SizedBox(height: 4),
                  appTextView(
                    text:
                        loggedInUserData.loggedInUserData.rider?.getEmail() ??
                        '',
                    size: AppDimensions.FONT_SIZE_14,
                    fontFamily: 'Roboto',
                    color: AppColors.TEXT_2,
                    fontWeight: FontWeight.w400,
                  ),
                  /*Padding(
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
                        debugPrint('Open Edit Profile');
                        Get.toNamed(AppRoutes.travelerEditProfile);
                      },
                    ),
                  ),*/
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
                  // _buildProfileOption(AppImages.icAddress, 'Address', () {
                  //   debugPrint('Open Address');
                  //   Get.toNamed(AppRoutes.addressList);
                  // }),

                  // const SizedBox(height: 20),
                  // _buildProfileOption(
                  //   AppImages.icPayment,
                  //   'Payment Method',
                  //   () {},
                  // ),
                  const SizedBox(height: 8),
                  _buildProfileOption(
                    AppImages.icNotificationY,
                    'Notification',
                    () {
                      Get.toNamed(AppRoutes.travelerNotifications);
                    },
                  ),

                  loggedInUserData.loggedInUserData.rider?.isSocialLogged() ??
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

                  // const SizedBox(height: 20),
                  // _buildProfileOption(
                  //   AppImages.icSecurity,
                  //   'Account Security',
                  //   () {
                  //     Get.toNamed(AppRoutes.changePassword);
                  //   },
                  // ),
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
                  // _buildProfileOption(AppImages.icRefund, 'Refunds', () {
                  //   Get.toNamed(AppRoutes.refundRequests);
                  // }),
                  const SizedBox(height: 8),
                  _buildProfileOption(
                    AppImages.icPrivacy,
                    'Privacy Policy',
                    () {
                      AppGlobal.instance.openLink(AppConstants.privacyPolicy);
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
                    LoggedInUserData.instance.logoutConfirmationSheet(false);
                  }, isLogout: true),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      LoggedInUserData.instance
                          .deleteAccountConfirmationSheetView(false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width,
                        child: appTextView(
                          fontFamily: 'Roboto',
                          text: "Delete Account",
                          underLine: TextDecoration.underline,
                          textAlign: TextAlign.center,
                          color: AppColors.RED,
                          size: 12,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: FutureBuilder(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox();
                          final info = snapshot.data!;
                          return appTextView(
                            fontFamily: 'Roboto',
                            text:
                                'Version ${info.version} (${info.buildNumber})',
                            textAlign: TextAlign.center,
                            color: AppColors.GRAY,
                            size: 12,
                          );

                          //   Text(
                          //   'Version ${info.version} (${info.buildNumber})',
                          //   style: const TextStyle(fontSize: 12),
                          // );
                        },
                      ),
                    ),
                  ),

                  // _buildProfileOption(AppImages.icLogout, 'Delete Account', () {
                  //   LoggedInUserData.instance
                  //       .deleteAccountConfirmationSheetView(false);
                  // }, isLogout: true),
                ],
              ),
            ],
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
