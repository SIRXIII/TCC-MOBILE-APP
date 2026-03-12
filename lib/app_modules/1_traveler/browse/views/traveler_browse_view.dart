// views/traveler_home_view.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/models/filter_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/views/sheets/filter_bottom_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/traveler_home_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text_field.dart';

class TravelerBrowseView extends StatelessWidget {
  TravelerBrowseView({super.key});

  final TravelerHomeController controller = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // drawer: _buildNavigationDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(),
      key: _scaffoldKey,
    );
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          /* // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: AppColors.PRIMARY_COLOR,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'John Traveler',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.traveler@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          _buildDrawerItem(
            Icons.home,
            'Home',
                () {
              Get.back(); // Close drawer
            },
            isSelected: true,
          ),
          _buildDrawerItem(
            Icons.explore,
            'Browse Services',
                () {
              Get.back();
              Get.find<TravelerDashboardController>().changeTabIndex(1);
            },
          ),
          _buildDrawerItem(
            Icons.card_travel,
            'My Trips',
                () {
              Get.back();
              Get.find<TravelerDashboardController>().changeTabIndex(2);
            },
          ),
          _buildDrawerItem(
            Icons.shopping_cart,
            'My Cart',
                () {
              Get.back();
              Get.find<TravelerDashboardController>().changeTabIndex(3);
            },
          ),
          _buildDrawerItem(
            Icons.person,
            'Profile',
                () {
              Get.back();
              Get.find<TravelerDashboardController>().changeTabIndex(4);
            },
          ),
          _buildDrawerItem(
            Icons.payment,
            'Payment Methods',
                () {
              Get.back();
              Get.snackbar(
                'Payment Methods',
                'Opening payment settings...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          _buildDrawerItem(
            Icons.local_offer,
            'Promotions',
                () {
              Get.back();
              Get.snackbar(
                'Promotions',
                'Showing available promotions...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          _buildDrawerItem(
            Icons.help,
            'Help & Support',
                () {
              Get.back();
              Get.snackbar(
                'Help & Support',
                'Opening support center...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          _buildDrawerItem(
            Icons.settings,
            'Settings',
                () {
              Get.back();
              Get.snackbar(
                'Settings',
                'Opening settings...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),

          // Divider
          const Divider(),*/

          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: _buildDrawerItem(Icons.logout, 'Logout', () {
              Get.back();

              // UserPreferences.instance.clearStorageAndLogout();
            }, isLogout: true),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isSelected = false,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout
            ? Colors.red
            : isSelected
            ? AppColors.PRIMARY_COLOR
            : Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : isSelected
              ? AppColors.PRIMARY_COLOR
              : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.PRIMARY_COLOR,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: 'Browse',
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
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.notifications_outlined),
      //     onPressed: () {
      //       appToastView(title: 'No new notifications');
      //     },
      //   ),
      // ],
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(70),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //     child: _buildSearchField(),
      //   ),
      // ),
    );
  }

  Widget _buildSearchField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Obx(() {
              return AppTextField(
                suffixIcon: controller.searchText.value == ''
                    ? SizedBox.shrink()
                    : InkWell(
                        child: Icon(Icons.close, color: Colors.grey[600]),
                        onTap: () {
                          controller.searchText.value = '';
                          controller.productsApiRequest();
                        },
                      ),
                isPrefix: true,
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                borderColor: Colors.grey[200]!,
                controller: TextEditingController(
                  text: controller.searchText.value,
                ),
                isborderline: true,
                hintSize: AppDimensions.FONT_SIZE_16,
                hintColor: AppColors.TEXT_1,
                hint: 'Search',
                borderRadius: BorderRadius.circular(8),

                onFieldSubmitted: (value) {
                  controller.searchProducts(value);
                },
                textInputAction: TextInputAction.search,
                // textInputType: TextInputType.emailAddress,
              );
            }),
            /*Row(
              children: [
                const SizedBox(width: 8),
                Icon(Icons.search, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search ',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    // onChanged: (value) => controller.searchProducts(value),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),*/
          ),
        ),
        GestureDetector(
          onTap: _openFilterSheet,
          child: Container(
            height: 38,
            width: 38,
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgIconWidget(assetName: AppImages.icFilter),
          ),
        ),
      ],
    );
  }

  // --> _buildBody
  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 16),
          _buildSearchField(),
          const SizedBox(height: 16),
          // --> Categories
          _buildCategoriesView(),

          // --> Products
          _buildProductsListView(),
          // const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _openFilterSheet() async {
    final result = await Get.bottomSheet<FilterModel>(
      FilterBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    if (result != null) {
      // Handle the filter results
    }
  }

  Widget _buildCategoriesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            appTextView(
              text: 'Categories',
              color: AppColors.BLACK,
              size: AppDimensions.FONT_SIZE_18,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              // isStroke: false,
            ),
            Spacer(),

            // Text(
            //   'View All',
            //   style: TextStyle(
            //     fontWeight: FontWeight.w500,
            //     fontSize: 12,
            //     color: AppColors.PRIMARY_COLOR,
            //   ),
            // ),
            // appTextView(
            //   text: 'View All',
            //   color: AppColors.PRIMARY_COLOR,
            //   size: AppDimensions.FONT_SIZE_12,
            //   textAlign: TextAlign.center,
            //   fontWeight: FontWeight.w500,
            //   // isStroke: false,
            // ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          final categories = controller.filterOptions.genders;

          return controller.filtersRequestLoader.isTrue
              ? appLoaderView()
              : SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories!.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _buildQuickActionItem(categories[index], index);
                    },
                  ),
                );
        }),
      ],
    );
  }

  Widget _buildQuickActionItem(String title, int index) {
    return Obx(() {
      bool isSelected = controller.selectedQuickActionIndex.value == index;

      return GestureDetector(
        onTap: () {
          controller.selectCategory(index, title);
          // onTap();
        },
        child: Column(
          children: [
            Container(
              // width: 60,
              // height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.PRIMARY_COLOR.withOpacity(0.1),
                shape: BoxShape.rectangle,
                borderRadius: AppBorderRadius.BORDER_RADIUS_8,
                border: Border.all(
                  color: isSelected
                      ? AppColors.PRIMARY_COLOR
                      : AppColors.PRIMARY_COLOR.withOpacity(0.3),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title.capitalizeFirst ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppColors.WHITE : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Icon(
              //   icon,
              //   color: isSelected ? Colors.white : color,
              //   size: 24,
              // ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProductsListView() {
    return Obx(
      () => SizedBox(
        // height: Get.height, // increase height to fit grid
        child: controller.productsApiRequestLoader.isTrue
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: appLoaderView(),
                ),
              )
            : controller.productsList.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: appTextView(
                    text: 'No record found',
                    size: AppDimensions.FONT_SIZE_16,
                    fontFamily: 'Roboto',
                    color: AppColors.BLACK,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.72, // adjust based on your card design
                ),
                itemCount: controller.productsList.length,
                itemBuilder: (context, index) {
                  Product service = controller.productsList[index];
                  return _buildFeaturedServiceCard(service);
                },
              ),
      ),
    );
  }

  Widget _buildFeaturedServiceCard(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () {
          LoggedInUserData.instance.setSelectedProduct = product;
          Get.toNamed(AppRoutes.productDetail);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppCacheImageView(
                  imageUrl: product.images![0].imageUrl ?? '',
                  height: Get.height * 0.15,
                  width: Get.width,
                  boxFit: BoxFit.cover,
                ),
                product.getRating() == ''
                    ? SizedBox.shrink()
                    : Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.WHITE, // background color for rating
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.PRIMARY_COLOR,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.getRating() ?? '0.0',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.getName(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   service['description'],
                  //   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${product.getPrice()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      ),
                      Text(
                        '/${product.getMinRental()} days',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.BLACK,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: AppCacheImageView(
                      imageUrl: product.partner?.getProfileImage() ?? '',
                      height:
                          20, // make sure width = height for a perfect circle
                      width: 20,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        product.partner?.getName() ?? 'N/A',
                        style: TextStyle(
                          fontSize: AppDimensions.FONT_SIZE_12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                  ),
                  /*  Flexible(
                    child: Text(
                      product.partner?.getName() ?? 'N/A',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.BLACK,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCard(Map<String, dynamic> promotion) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        color: promotion['color'] as Color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () => controller.applyPromotion(promotion['code']),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promotion['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  promotion['description'],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Use code: ${promotion['code']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
