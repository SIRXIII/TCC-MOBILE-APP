// controllers/product_details_controller.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import '../models/product_model.dart';

class ProductDetailsController extends GetxController {
  // -----------------------------------
  // PROPERTIES
  // -----------------------------------
  final Rx<Product?> product = Rx<Product?>(null);
  // final RxInt currentImageIndex = 0.obs;
  final RxString selectedSize = ''.obs;

  /// Selected color
  final Rx<ProductColor?> selectedColor = Rx<ProductColor?>(null);

  void selectColor(ProductColor color) {
    selectedColor.value = color;
  }

  // ProductColor selectedColorModel(ProductColor productColor) {
  //   return selectedColor.value == productColor;
  // }
  //
  bool isSelected(ProductColor color) {
    return selectedColor.value?.name == color.name;
  }

  // final RxString selectedColor = ''.obs;
  final RxInt quantity = 1.obs;
  final RxBool isFavorite = false.obs;

  RxInt selectedRentalDayValue = (-1).obs;

  void selectRentalDayValue(int value) {
    selectedRentalDayValue.value = value;
  }

  void setProduct(Product newProduct) {
    product.value = newProduct;
    // isFavorite.value = newProduct.isFavorite;
    // if (newProduct.sizes.isNotEmpty) {
    //   selectedSize.value = newProduct.sizes.first;
    // }
    // if (newProduct.colors.isNotEmpty) {
    //   selectedColor.value = newProduct.colors.first;
    // }
  }

  // void changeImageIndex(int index) {
  //   currentImageIndex.value = index;
  // }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void increaseQuantity() {
    if (quantity.value < (product.value?.stock ?? 1)) {
      quantity.value++;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Get.snackbar(
      isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
      product.value?.name ?? '',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void buyNow() {
    if (selectedSize.value.isEmpty ||
        selectedColor.value ==
            ProductColor(name: '', color: AppColors.TRANSPARENT)) {
      Get.snackbar(
        'Selection Required',
        'Please select size and color',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.toNamed(
      '/checkout',
      arguments: {
        'product': product.value,
        'size': selectedSize.value,
        'color': selectedColor.value,
        'quantity': quantity.value,
      },
    );
  }

  double get totalPrice {
    return (double.parse(product.value!.basePrice!) ?? 0) * quantity.value;
  }

  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  late List images;
  Timer? _timer;

  void setImages(List imgs) {
    images = imgs;
    _startAutoSlide();
  }

  void changeImageIndex(int index) {
    currentIndex.value = index;
  }

  void _startAutoSlide() {
    _timer?.cancel();
    if (images.length <= 1) return;

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = (currentIndex.value + 1) % images.length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
