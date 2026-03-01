// views/cart_list_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_item_model.dart';

class CartListView extends StatelessWidget {
  CartListView({super.key});

  final CartController cartController = Get.put(CartController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: appTextView(
          text: 'Cart',
          color: AppColors.BLACK,
          size: AppDimensions.FONT_SIZE_18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          // isStroke: false,
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.PRIMARY_COLOR,
        // leading: IconButton(
        //   icon: SvgIconWidget(assetName: AppImages.icDrawer, size: 36),
        //   onPressed: () {
        //     _scaffoldKey.currentState!.openDrawer();
        //     // Scaffold.of(context).openEndDrawer(); // Open the end drawer
        //   },
        // ),
        actions: [
          Obx(
            () => cartController.cartItems.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: _showClearCartDialog,
                    tooltip: 'Clear Cart',
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: Obx(
        () => cartController.isLoading.value
            ? _buildLoadingState()
            : cartController.cartItems.isEmpty
            ? _buildEmptyState()
            : _buildCartContent(),
      ),
      bottomNavigationBar: Obx(
        () => cartController.cartItems.isEmpty
            ? SizedBox.shrink()
            : _buildBottomSummary(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 70,
            color: AppColors.PRIMARY_COLOR,
          ),
          const SizedBox(height: 20),
          appTextView(
            text: 'Your Cart is Empty',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 10),
          appTextView(
            text: 'Add some items to get started',
            size: AppDimensions.FONT_SIZE_14,
            fontFamily: 'Roboto',
            color: AppColors.TEXT_1,
            // fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 16,
              left: 12,
              right: 12,
            ),
            children: [
              // Cart Items List
              ...cartController.cartItems.map((item) => _buildCartItem(item)),
              const SizedBox(height: 20),

              // Order Summary
              // _buildOrderSummary(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCacheImageView(
                  imageUrl: item.productImage,
                  height: Get.height * 0.12,
                  width: Get.width * 0.25,
                ),

                const SizedBox(width: 12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                              left: 4,
                              right: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appTextView(
                                  text: item.productName,
                                  size: AppDimensions.FONT_SIZE_14,
                                  fontFamily: 'Roboto',
                                  color: AppColors.BLACK,
                                  fontWeight: FontWeight.w500,
                                ),

                                // const SizedBox(height: 4),
                                // Text(
                                //   item.productBrand,
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.grey.shade600,
                                //   ),
                                // ),
                                const SizedBox(height: 8),
                                appTextView(
                                  text: 'Size: ${item.size}',
                                  size: AppDimensions.FONT_SIZE_12,
                                  fontFamily: 'Roboto',
                                  color: AppColors.BLACK,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          // // Delete Button
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 18,
                            ),
                            onPressed: () => _showDeleteDialog(item),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 8),
                        child: Row(
                          children: [
                            appTextView(
                              text: 'Rental Duration: ',
                              size: AppDimensions.FONT_SIZE_12,
                              fontFamily: 'Roboto',
                              color: AppColors.BLACK,
                              // fontWeight: FontWeight.bold,
                            ),
                            appTextView(
                              text: '${item.rentalDays} Days',
                              size: AppDimensions.FONT_SIZE_12,
                              fontFamily: 'Roboto',
                              color: AppColors.BLACK,
                              // fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            appTextView(
                              text:
                                  '\$${item.productPrice.toStringAsFixed(2)} ',
                              size: AppDimensions.FONT_SIZE_12,
                              fontFamily: 'Roboto',
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),

                      // const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 12),

            // Quantity Controls and Subtotal
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
                top: 6.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Controls
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                      shape: BoxShape.rectangle,
                      borderRadius: AppBorderRadius.BORDER_RADIUS_8,
                      border: Border.all(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.3),
                        width: 1,
                      ),
                    ),

                    child: Row(
                      children: [
                        // Decrease Button
                        IconButton(
                          icon: const Icon(Icons.remove, size: 14),
                          onPressed: item.quantity > 1
                              ? () {
                                  cartController.updateQuantity(
                                    item.id!,
                                    item.quantity - 1,
                                  );
                                }
                              : null,
                          style: IconButton.styleFrom(
                            foregroundColor: item.quantity > 1
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),

                        // Quantity Display
                        SizedBox(
                          width: 10,
                          child: Text(
                            item.quantity.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // Increase Button
                        IconButton(
                          icon: const Icon(Icons.add, size: 14),
                          onPressed: () {
                            cartController.updateQuantity(
                              item.id!,
                              item.quantity + 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Subtotal
                  Text(
                    '\$${cartController.calculateItemSubtotal(item).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Subtotal
            _buildSummaryRow(
              'Subtotal',
              '\$${cartController.cartTotal.value.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),

            // Shipping
            _buildSummaryRow('Shipping', 'Free'),
            const SizedBox(height: 8),

            // Service Fee
            _buildSummaryRow('Service Fee', '\$5.00'),
            const SizedBox(height: 12),

            const Divider(),
            const SizedBox(height: 12),

            // Total
            _buildSummaryRow(
              'Total',
              '\$${(cartController.cartTotal.value + 5.00).toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.green : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Total and Items Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    // Obx(
                    //   () => Text(
                    //     '${cartController.cartItemsCount.value} items',
                    //     style: TextStyle(
                    //       fontSize: 14,
                    //       color: Colors.grey.shade600,
                    //     ),
                    //   ),
                    // ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '\$${(cartController.cartTotal.value).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.BLACK,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Checkout Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Obx(
                      () => CustomButton(
                        text: cartController.placeOrderApiResuestLoader.isFalse
                            ? 'Proceed to Checkout'
                            : 'Placing Order...',
                        height: 40,
                        onPressed: _proceedToCheckout,
                        isEnabled:
                            cartController.placeOrderApiResuestLoader.isFalse,
                      ),

                      // cartController.placeOrderApiResuestLoader.isTrue
                      //     ? SizedBox(
                      //         height: 40,
                      //         width: 40,
                      //         child: appLoaderView(),
                      //       )
                      //     : appButtonView(
                      //         buttonHeight: 40,
                      //         buttonName: 'Proceed to Checkout',
                      //         buttonColor: AppColors.PRIMARY_COLOR,
                      //         textColor: AppColors.WHITE,
                      //         onTap: _proceedToCheckout,
                      //       ),
                    ),
                    // ElevatedButton(
                    //   onPressed: _proceedToCheckout,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.purple,
                    //     foregroundColor: Colors.white,
                    //     padding: const EdgeInsets.symmetric(vertical: 16),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    //   child: const Text(
                    //     'Proceed to Checkout',
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(CartItem item) {
    Get.dialog(
      AlertDialog(
        title: const Text('Remove Item'),
        content: const Text(
          'Are you sure you want to remove this item from your cart?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              cartController.removeFromCart(item.id!);
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              cartController.clearCart();
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // --> _proceedToCheckout
  Future<void> _proceedToCheckout() async {
    if (cartController.cartItems.isEmpty) {
      Get.snackbar(
        'Cart Empty',
        'Please add items to your cart before checkout',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    cartController.placeOrderApiResuest();
    //
    // // Navigate to checkout screen
    // Get.snackbar(
    //   'Coming Soon!',
    //   'Checkout feature will be available soon!',
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: AppColors.PRIMARY_COLOR,
    //   colorText: Colors.white,
    // );

    // Uncomment when you have checkout screen
    // Get.to(() => CheckoutView());
  }
}
