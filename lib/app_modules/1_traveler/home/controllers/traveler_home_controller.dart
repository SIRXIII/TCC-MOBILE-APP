import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/models/filter_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/dashboard/controllers/traveler_dashboard_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/filters/model/filter_options_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/products_api_response.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/repositories/filters_respository.dart';
import 'package:travel_clothing_club_flutter/repositories/product_repository.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart'
    show appToastView;

class TravelerHomeController extends GetxController {
  // -----------------------------------
  // onInit
  // -----------------------------------
  @override
  void onInit() {
    super.onInit();
    _fetchCurrentLocation();
    _initializeController();
  }

  // -----------------------------------
  // _initializeController
  // -----------------------------------
  Future<void> _initializeController() async {
    try {
      // Run parallel async operations
      await Future.wait([filterOptionsApiRequest(), productsApiRequest()]);
    } catch (e, s) {
      // Handle or log any errors gracefully
    }
  }

  // -----------------------------------
  // Category Selection Stuff
  // -----------------------------------
  final RxInt selectedQuickActionIndex =
      (-1).obs; // -1 means no category selected

  void selectCategory(int index, String categoryName) {
    if (selectedQuickActionIndex.value == index) {
      // If already selected, unselect it
      selectedQuickActionIndex.value = -1;
      productsApiRequest(category: '');
    } else {
      // Otherwise, select it
      selectedQuickActionIndex.value = index;
      productsApiRequest(category: categoryName);
    }
  }

  // -----------------------------------
  // Filter Options
  // -----------------------------------
  var filtersRequestLoader = false.obs;

  final Rx<FiltersData> _filtersData = FiltersData().obs;

  FiltersData get filterOptions => _filtersData.value;

  set setFiltersOption(FiltersData data) {
    _filtersData.value = data;
  }

  Future<void> filterOptionsApiRequest() async {

    filtersRequestLoader(true);

    var response = await FiltersRepository.instance.travelerFiltersOptions({});

    final filtersApiResponse = filtersApiResponseFromJson(response);

    if (response != null) {
      if (filtersApiResponse.success ?? false) {
        // appToastView(title: productsApiResponse.message.toString());

        setFiltersOption = filtersApiResponse.data!;
        // _loggedInUserData.value = authApiResponse.data!;
        // Get.toNamed(AppRoutes.login);
        // Get.toNamed(Routes.login);
        filtersRequestLoader(false);
      } else {
        appToastView(title: filtersApiResponse.message.toString());
      }
      filtersRequestLoader(false);
    }
    filtersRequestLoader(false);
  }

  // -----------------------------------
  // Promotions
  // -----------------------------------
  final _promotionalProducts = <Product>[].obs;

  RxList<Product> get promotionalProducts => _promotionalProducts;

  set setPromotionalProducts(List<Product> productsList) {
    _promotionalProducts.value = List.from(productsList);
  }

  // -----------------------------------
  // Product API
  // -----------------------------------
  var productsApiRequestLoader = false.obs;
  final _products = <Product>[].obs;

  RxList<Product> get productsList => _products;

  set setProducts(List<Product> productsList) {
    _products.value = List.from(productsList);
  }

  Future<void> productsApiRequest({
    String perPage = '20',
    String category = '',
    FilterModel? filterModel,
  }) async {

    productsApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      'per_page': perPage,
      'status': 'Active',
      // "brands": ["Fisher and Sons", "Reichel PLC"],
      'sort_order': 'asc',
      'search': searchText.value,
    };

    if (category.isNotEmpty) {
      // requestBody['category'] = category;
      requestBody['gender'] = category;
    }

    if (filterModel != null) {
      // requestBody['brands'] = ["Fisher and Sons", "Reichel PLC"];
      requestBody['brands'] = filterModel.selectedBrands;
      requestBody['sizes'] = filterModel.size;
      requestBody['min_price'] = filterModel.minPrice;
      requestBody['max_price'] = filterModel.maxPrice;
      requestBody['rental_days'] = filterModel.getDaysFromString();
      // requestBody['type'] = ""; // (rental, formal),
    }

    var response = await ProductRepository.instance.travelerProducts(
      requestBody,
    );

    final productsApiResponse = productsApiResponseFromJson(response);

    if (response != null) {
      if (productsApiResponse.success ?? false) {
        // appToastView(title: productsApiResponse.message.toString());

        if (_promotionalProducts.isEmpty) {
          final products = productsApiResponse.data?.products ?? [];

          // Take first 3 products safely (if available)
          setPromotionalProducts = products.take(3).toList();
        }

        setProducts = productsApiResponse.data?.products ?? [];
        // _loggedInUserData.value = authApiResponse.data!;
        // Get.toNamed(AppRoutes.login);
        // Get.toNamed(Routes.login);
        productsApiRequestLoader(false);

        if (productsList == []) {
          appToastView(title: 'No record found');
        }
      } else {
        appToastView(title: productsApiResponse.message.toString());
      }
      productsApiRequestLoader(false);
    }
    productsApiRequestLoader(false);
  }

  final RxList<Map<String, dynamic>> recentTrips = <Map<String, dynamic>>[
    {
      'id': '1',
      'from': 'Home',
      'to': 'Office',
      'date': 'Today, 8:30 AM',
      'price': '\$18.50',
      'status': 'completed',
    },
    {
      'id': '2',
      'from': 'Mall',
      'to': 'Home',
      'date': 'Yesterday, 5:15 PM',
      'price': '\$12.75',
      'status': 'completed',
    },
  ].obs;

  // // Promotions
  // final RxList<Map<String, dynamic>> promotions = <Map<String, dynamic>>[
  //   {
  //     'id': '1',
  //     'title': 'Rent the Style, Not the price',
  //     'description': 'Get your first ride free up to \$20',
  //     'code': 'WELCOME20',
  //     'color': Colors.blue,
  //   },
  //   {
  //     'id': '2',
  //     'title': 'Weekend Special',
  //     'description': '20% off on all weekend rides',
  //     'code': 'WEEKEND20',
  //     'color': Colors.green,
  //   },
  // ].obs;

  // User location
  final RxString? currentLocation = 'Fetching location...'.obs;
  // final RxString destination = ''.obs;

  void _fetchCurrentLocation() {
    // Simulate location fetch
    Future.delayed(const Duration(seconds: 2), () {
      currentLocation?.value =
          UserPreferences.instance.loggedInUserData.traveler?.getLocation() ??
          '';
    });
  }

  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  void searchProducts(String query) {
    searchText.value = query;
    productsApiRequest();
  }

  void viewTripDetails(Map<String, dynamic> trip) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Trip Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            _buildTripDetailRow('From', trip['from']),
            _buildTripDetailRow('To', trip['to']),
            _buildTripDetailRow('Date', trip['date']),
            _buildTripDetailRow('Price', trip['price']),
            _buildTripDetailRow('Status', trip['status']),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void applyPromotion(String code) {
    Get.snackbar(
      'Promotion Applied!',
      'Code: $code has been applied',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void navigateToBrowse() {
    // This would navigate to browse tab in the main dashboard
    Get.find<TravelerDashboardController>().changeTabIndex(1);
  }

  void navigateToOrders() {
    Get.find<TravelerDashboardController>().changeTabIndex(2);
  }
}
