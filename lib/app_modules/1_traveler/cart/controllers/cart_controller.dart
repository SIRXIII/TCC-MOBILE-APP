// controllers/cart_controller.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/traveler_home_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/place_order_api_response.dart'
    hide Product;
import 'package:travel_clothing_club_flutter/repositories/order_repository.dart';
import 'package:travel_clothing_club_flutter/service/stripe_service.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';
import '../models/cart_item_model.dart';
import '../database/database_helper.dart';

class CartController extends GetxController {
  // --> PROPERTIES
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  // final RxInt cartItemsCount = 0.obs;
  // final RxDouble cartTotal = 0.0.obs;
  final RxBool isLoading = false.obs;
  RxInt get cartItemsCount => _cartItemsCount;
  RxDouble get cartTotal => _cartTotal;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  // Load cart items from database
  Future<void> loadCartItems() async {
    isLoading.value = true;
    try {
      final items = await _databaseHelper.getCartItems();
      cartItems.assignAll(items);
      await _updateCartSummary();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add product to cart
  Future<void> addToCart({
    required Product product,
    required String size,
    required String color,
    required int rentalDays,
    int quantity = 1,
  }) async {
    if (size == '') {
      appToastView(title: 'Size is required');
      return;
    }

    // if (kDebugMode) {
    //   color = "RED";
    // }
    if (color == '') {
      appToastView(title: 'Color is required');
      return;
    }
    try {
      final cartItem = CartItem(
        productId: product.id ?? 0,
        productName: product.getName(),
        productDescription: product.getNote(),
        productPrice: product.getPrice(),
        productImage: product.images![0].imageUrl ?? '',
        productBrand: product.category ?? '',
        size: size,
        color: color,
        rentalDays: rentalDays,
        quantity: quantity,
        addedAt: DateTime.now(),
        partnerId: product.partner!.getPartnerId(),
      );

      await _databaseHelper.addToCart(cartItem);
      await loadCartItems(); // Reload cart items

      // appTextView(text: '${product.name} added to cart');
      Get.snackbar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        colorText: AppColors.WHITE,
        'Success',
        '${product.name} added to cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart: $e');
    }
  }

  // Update item quantity
  Future<void> updateQuantity(int itemId, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeFromCart(itemId);
      return;
    }

    try {
      await _databaseHelper.updateQuantity(itemId, newQuantity);
      await loadCartItems(); // Reload cart items
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity: $e');
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(int itemId) async {
    try {
      await _databaseHelper.removeFromCart(itemId);
      await loadCartItems(); // Reload cart items

      appToastView(title: 'Item removed from cart');

      // Get.snackbar(
      //   'Removed',
      //   'Item removed from cart',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 2),
      // );
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove item from cart: $e');
    }
  }

  // Clear entire cart
  Future<void> clearCart() async {
    try {
      await _databaseHelper.clearCart();
      cartItems.clear();
      await _updateCartSummary();

      // appToastView(title: title)
      // Get.snackbar(
      //   'Cart Cleared',
      //   'All items removed from cart',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } catch (e) {
      appToastView(title: 'Failed to clear cart: $e');
      // Get.snackbar('Error', 'Failed to clear cart: $e');
    }
  }

  // Check if product is in cart
  Future<bool> isProductInCart(
    int productId,
    String size,
    int rentalDays,
  ) async {
    return await _databaseHelper.isProductInCart(productId, size, rentalDays);
  }

  /*  // Get item quantity in cart
  int getItemQuantity(int productId, String size, int rentalDays) {
    final item = cartItems.firstWhere(
      (item) =>
          item.productId == productId &&
          item.size == size &&
          item.rentalDays == rentalDays,
      orElse: () => CartItem(
        productId: 0,
        productName: '',
        productDescription: '',
        productPrice: 0,
        productImage: '',
        productBrand: '',
        size: '',
        color: '',
        rentalDays: 0,
        addedAt: DateTime.now(),
        partnerId: 0,
      ),
    );
    return item.quantity;
  }*/

  // Calculate subtotal for a specific item
  double calculateItemSubtotal(CartItem item) {
    return item.productPrice * item.quantity * item.rentalDays;
  }

  // Get cart items count (reactive)
  final RxInt _cartItemsCount = 0.obs;

  // Get cart total (reactive)
  final RxDouble _cartTotal = 0.0.obs;

  // Update cart summary
  Future<void> _updateCartSummary() async {
    int totalCount = 0;
    double totalAmount = 0.0;

    for (var item in cartItems) {
      totalCount += item.quantity;
      totalAmount += calculateItemSubtotal(item);
    }

    _cartItemsCount.value = totalCount;
    _cartTotal.value = totalAmount;
  }

  // --> PLace order
  var placeOrderApiResuestLoader = false.obs;
  final UserPreferences userPreferences = UserPreferences.instance;

  final TravelerHomeController travelerHomeController = Get.find();

  Future<void> placeOrderApiResuest() async {
    debugPrint('placeOrderApiResuest --> ');
    // CartItem item = cartItems[0];

    placeOrderApiResuestLoader(true);

    var stripeResponse = await StripeService.payWithPaymentSheet(
      amount: (cartTotal.value * 100).toInt().toString(),
      currency: 'usd',
      from: '',
      context: Get.context!,
    );

    if (stripeResponse.message == 'Transaction successful') {
      // Convert every CartItem to JSON format
      List<Map<String, dynamic>> items = cartItems.map((item) {
        return {
          'partner_id': item.partnerId,
          'product_id': item.productId,
          'size': item.size == '' ? 'M' : item.size,
          'color': item.color,
          'quantity': item.quantity,
          'rental_days': item.rentalDays,
          'payment_intent_id': stripeResponse.stripePayId,
          'payment': true,
          'status': true,
        };
      }).toList();

      // Final request body
      Map<String, dynamic> requestBody = {
        'traveler_id': userPreferences.loggedInUserData.traveler
            ?.getTravelerId(),
        'items': items,
      };

      var response = await OrderRepository.instance.placeOrder(requestBody);

      final productsApiResponse = placeOrderApiResponseFromJson(response);

      if (response != null) {
        if (productsApiResponse.success ?? false) {
          appToastView(title: productsApiResponse.message.toString());

          clearCart();
          travelerHomeController.productsApiRequest();

          placeOrderApiResuestLoader(false);
        } else {
          placeOrderApiResuestLoader(false);
          try {
            // appToastView(title: productsApiResponse.message.toString());
            appToastView(
              title:
                  productsApiResponse.errors?.details?.getAllErrors() ??
                  productsApiResponse.errors?.message ??
                  productsApiResponse.message.toString(),
            );
          } catch (e) {
            AppLogger.debugPrintLogs(
              'placeOrderApiResuest - error',
              e.toString(),
            );
            appToastView(title: productsApiResponse.message.toString());
          }
        }
        placeOrderApiResuestLoader(false);
      }
    }

    placeOrderApiResuestLoader(false);
  }
}
