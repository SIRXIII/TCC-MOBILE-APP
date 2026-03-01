// controllers/filter_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/filter_model.dart';

class FilterController extends GetxController {
  final Rx<FilterModel> filters = FilterModel().obs;

  var selectedRating = 0.obs; // 0 = none selected
  // Observable price range
  final priceRange = const RangeValues(35, 200).obs;

  // Getter
  RangeValues get currentPriceRange => priceRange.value;

  // Setter
  void setPriceRange(RangeValues newRange) {
    priceRange.value = newRange;
  }

  void toggleBrowse() {
    filters.update((val) {
      val?.browse = !val.browse;
    });
  }

  void toggleSearch() {
    filters.update((val) {
      val?.search = !val.search;
    });
  }

  void setRentalDuration(String duration) {
    filters.update((val) {
      val?.rentalDuration = duration;
    });
  }

  // void toggleBrand(String brand) {
  //   filters.update((val) {
  //     if (val!.selectedBrands.contains(brand)) {
  //       val.selectedBrands.remove(brand);
  //     } else {
  //       val.selectedBrands.add(brand);
  //     }
  //   });
  // }
  void toggleBrand(String brand) {
    filters.update((val) {
      if (val == null) return;

      // make a mutable copy
      final updatedBrands = List<String>.from(val.selectedBrands);

      if (updatedBrands.contains(brand)) {
        updatedBrands.remove(brand);
      } else {
        updatedBrands.add(brand);
      }

      // reassign it
      val.selectedBrands = updatedBrands;
    });
  }

  void setRating(double rating) {
    filters.update((val) {
      val?.minRating = rating;
    });
  }

  void setSize(String size) {
    filters.update((val) {
      val?.size = size;
    });
  }

  void selectedPriceRange(double min, double max) {
    filters.update((val) {
      val?.minPrice = min;
      val?.maxPrice = max;
    });
  }

  void resetFilters() {
    filters.value = FilterModel();
  }

  void applyFilters() {
    Get.back(result: filters.value);
  }
}
