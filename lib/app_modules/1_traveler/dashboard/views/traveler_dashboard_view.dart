import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/views/traveler_browse_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/cart/views/cart_list_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/views/traveler_home_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/views/traveler_orders_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/profile/views/traveler_profile_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import '../controllers/traveler_dashboard_controller.dart';

class TravelerDashboardView extends StatefulWidget {
  const TravelerDashboardView({super.key});

  @override
  State<TravelerDashboardView> createState() => _TravelerDashboardViewState();
}

class _TravelerDashboardViewState extends State<TravelerDashboardView> {
  /// --> PROPERTIES
  late final TravelerDashboardController controller;
  late final AuthController authController = AuthController.instance;
  final UserPreferences userPreferences = UserPreferences.instance;

  /// --> initState
  @override
  void initState() {
    super.initState();
    controller = Get.put(TravelerDashboardController());
    _initData();
  }

  /// --> _initData
  Future<void> _initData() async {
    debugPrint("🚀 Initializing Traveler Dashboard...");
    // call your initial API or setup logic here
    userPreferences.getLoggedInUserData();

    // Get.toNamed(AppRoutes.profileSetup);
    await Future.wait([
      authController.profileApiRequest(),

      AuthController.instance.updateFcmTokenApiRequest(),
      controller.checkLocationPermission(),
    ]);

    // if (userPreferences.loggedInUserData.traveler?.getSize() == '') {
    //   Get.toNamed(AppRoutes.profileSetup);
    // }
    // await authController.profileApiRequest();
    // await controller.checkLocationPermission();
  }

  /// --> Dispose
  @override
  void dispose() {
    // cleanup if necessary
    // Get.delete<TravelerDashboardController>();
    super.dispose();
  }

  /// --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => _buildCurrentTab()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCurrentTab() {
    switch (controller.currentTabIndex.value) {
      case 0:
        return TravelerHomeView();
      case 1:
        return TravelerBrowseView();
      case 2:
        return TravelerOrdersView();
      // return _buildOrdersTab();
      case 3:
        return CartListView();
      // return _buildCartTab();
      case 4:
        // return Center(child: appTextView(text: 'In Progress'));
        return TravelerProfileView();
      default:
        return TravelerHomeView();
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
          BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icHome),
            activeIcon: SvgIconWidget(assetName: AppImages.icHomeActive),
            // activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icBrowse),
            activeIcon: SvgIconWidget(assetName: AppImages.icBrowseActive),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icOrders),
            activeIcon: SvgIconWidget(assetName: AppImages.icOrdersActive),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icCart),
            activeIcon: SvgIconWidget(assetName: AppImages.icCartActive),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgIconWidget(assetName: AppImages.icProfile),
            activeIcon: SvgIconWidget(assetName: AppImages.icProfileActive),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Orders Tab
  Widget _buildOrdersTab() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text(
            'My Orders',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
          floating: true,
          snap: true,
        ),
        Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final order = controller.orders[index];
              return Card(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: ListTile(
                  leading: const Icon(Icons.receipt, color: Colors.green),
                  title: Text('Order #${order['id']}'),
                  subtitle: Text('Date: ${order['date']}'),
                  trailing: Chip(
                    label: Text(
                      order['status']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: order['status'] == 'Completed'
                        ? Colors.green
                        : Colors.orange,
                  ),
                  onTap: () {
                    Get.snackbar(
                      'Order Details',
                      'Showing details for Order #${order['id']}',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              );
            }, childCount: controller.orders.length),
          ),
        ),
      ],
    );
  }

  // Cart Tab
  Widget _buildCartTab() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
          floating: true,
          snap: true,
        ),
        Obx(
          () => SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (controller.cartItems.isEmpty)
                    Column(
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Browse services and add them to your cart',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            controller.changeTabIndex(1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Browse Services'),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        ...controller.cartItems.asMap().entries.map(
                          (entry) => Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: const Icon(
                                Icons.local_offer,
                                color: Colors.green,
                              ),
                              title: Text(entry.value),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  controller.removeFromCart(entry.key);
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          color: Colors.green[50],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Items:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${controller.cartItems.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.snackbar(
                                'Checkout',
                                'Proceeding to checkout...',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(fontSize: 16),
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
      ],
    );
  }
}
