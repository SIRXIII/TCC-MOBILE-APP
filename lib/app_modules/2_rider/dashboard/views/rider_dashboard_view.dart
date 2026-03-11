import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/dashboard/controllers/rider_dashboard_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/views/deliveries_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/profile/views/rider_profile_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/returns/views/rider_returns_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/views/rider_support_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_constants.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_images.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/svg_icon_widget.dart';

class RiderDashboardView extends StatefulWidget {
  const RiderDashboardView({super.key});

  @override
  State<RiderDashboardView> createState() => _RiderDashboardViewState();
}

class _RiderDashboardViewState extends State<RiderDashboardView> {
  // --> PROPERTIES
  late final RiderDashboardController controller;
  late final AuthController authController = AuthController.instance;
  final UserPreferences userPreferences = UserPreferences.instance;

  // --> initState
  @override
  void initState() {
    super.initState();
    controller = Get.put(RiderDashboardController());
    _initData();
  }

  Future<void> _initData() async {
    // call your initial API or setup logic here
    UserPreferences.instance.getLoggedInUserData();

    await Future.wait([
      authController.profileApiRequest(),
      controller.checkLocationPermission(),
      authController.updateFcmTokenApiRequest(),
    ]);

    // await authController.profileApiRequest();
    // await controller.checkLocationPermission();
  }

  @override
  void dispose() {
    // cleanup if necessary
    // Get.delete<TravelerDashboardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Obx(() => _buildCurrentTab()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // --> _buildAppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.BLACK,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                switch (controller.currentTabIndex.value) {
                  case 0:
                    return appTextView(
                      text:
                          'Hello, ${userPreferences.loggedInUserData.rider?.getName()} 👋',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      // isStroke: false,
                    );

                  case 1:
                    return appTextView(
                      text: 'Returns',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      // isStroke: false,
                    );
                  case 2:
                    return appTextView(
                      text: 'Support',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      // isStroke: false,
                    );
                  case 3:
                    return appTextView(
                      text: 'Profile',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      // isStroke: false,
                    );

                  default:
                    return appTextView(
                      text:
                          'Hello, ${userPreferences.loggedInUserData.rider?.getName()} ${AppConstants.emojiHand}',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      // isStroke: false,
                    );
                }
              }),

              userPreferences.loggedInUserData.rider == null
                  ? SizedBox.shrink()
                  : Obx(
                      () => controller.currentTabIndex.value == 0
                          ? userPreferences.loggedInUserData.rider!
                                    .getLocation()
                                    .contains('null')
                                ? SizedBox.shrink()
                                : InkWell(
                                    onTap: () {
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          userPreferences.loggedInUserData.rider
                                                  ?.getLocation() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.TEXT_1,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.TEXT_1,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  )
                          : SizedBox.shrink(),
                    ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (controller.currentTabIndex.value) {
      case 0:
        return DeliveriesView();

      case 1:
        return RiderReturnsView();
      case 2:
        // return Center(child: appTextView(text: 'Coming soon'));
        return RiderSupportView();
      case 3:
        return RiderProfileView();
        return Center(child: appTextView(text: 'In Progress'));
      // return _buildCartTab();
      // return _buildProfileTab();
      default:
        return DeliveriesView();
    }
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentTabIndex.value,
        onTap: controller.changeTabIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.PRIMARY_COLOR,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: [
          const BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icDeliveries),
            activeIcon: SvgIconWidget(
              assetName: AppImages.icDeliveriesSelected,
            ),
            // activeIcon: Icon(Icons.home),
            label: 'Deliveries',
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_outlined),
          //   activeIcon: Icon(Icons.home),
          //   label: 'Deliveries',
          // ),
          const BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icReturns),
            activeIcon: SvgIconWidget(assetName: AppImages.icReturnsSelected),
            label: 'Returns',
          ),
          BottomNavigationBarItem(
            icon: const SvgIconWidget(assetName: AppImages.icSupport),
            activeIcon: SvgIconWidget(
              assetName: AppImages.icSupport,
              color: AppColors.PRIMARY_COLOR,
            ),
            label: 'Support',
          ),

          const BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icProfile),
            activeIcon: SvgIconWidget(assetName: AppImages.icProfileActive),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
