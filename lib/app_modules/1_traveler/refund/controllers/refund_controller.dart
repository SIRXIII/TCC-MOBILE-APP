// controllers/refund_controller.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/models/refund_requests_api_response.dart'
    hide Order;
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/repositories/refund_repository.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';
import '../models/refund_request_model.dart';
import 'package:dio/dio.dart' as dio;

class RefundController extends GetxController {
  // --> Properties
  final RxList<RefundRequest> refundRequests = <RefundRequest>[].obs;
  final RxList<File> selectedImages = <File>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final UserPreferences userPreferences = UserPreferences.instance;
  final ImagePicker _imagePicker = ImagePicker();

  // --> onInit

  final _refundReasons = <String>[
    'Product not found',
    'Broken Product',
    'Product not as Described',
  ].obs;

  RxList<String> get reasonsForRefund => _refundReasons;

  set setReasonsForRefund(List<String> reasons) {
    _refundReasons.value = List.from(reasons);
  }

  final Rx<String> _selectedReason = ''.obs;
  String? get selectedReason => _selectedReason.value;

  void setSelectedReason(String reason) {
    _selectedReason.value = reason;
    update();
  }

  Future<void> pickImages() async {
    final List<XFile> files = await _imagePicker.pickMultiImage(
      imageQuality: 85,
    );

    for (var file in files) {
      selectedImages.add(File(file.path));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> submitRefundRequest({
    required String orderId,
    required String orderItem,
    required double amount,
    required RefundReason reason,
    required String description,
  }) async {
    if (description.isEmpty) {
      Get.snackbar(
        'Error',
        'Please provide a description',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isSubmitting.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    final newRequest = RefundRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      orderId: orderId,
      orderItem: orderItem,
      amount: amount,
      reason: reason,
      description: description,
      imageUrls: selectedImages.map((image) => image.path).toList(),
      status: RefundStatus.pending,
      createdAt: DateTime.now(),
    );

    refundRequests.insert(0, newRequest);
    selectedImages.clear();
    isSubmitting.value = false;

    Get.back();
    Get.snackbar(
      'Success',
      'Refund request submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void cancelRefundRequest(String requestId) {
    refundRequests.removeWhere((request) => request.id == requestId);
    Get.snackbar(
      'Cancelled',
      'Refund request cancelled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  List<RefundRequest> get pendingRequests {
    return refundRequests
        .where((request) => request.status == RefundStatus.pending)
        .toList();
  }

  List<RefundRequest> get processedRequests {
    return refundRequests
        .where((request) => request.status != RefundStatus.pending)
        .toList();
  }

  // -----------------------------------
  // Get Refund Requests API
  // -----------------------------------

  var selectedRefund = Refund();

  var getRefundsRequestApiRequestLoader = false.obs;
  final _refunds = <Refund>[].obs;

  RxList<Refund> get refundRequestsList => _refunds;

  set setRefundsRequestList(List<Refund> refundsList) {
    _refunds.value = List.from(refundsList);
  }

  Future<void> getRefundsRequestApiRequest() async {

    getRefundsRequestApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      "traveler_id":
          userPreferences.loggedInUserData.traveler?.getTravelerId() ?? '',
    };

    var response = await RefundRepository.instance.getRefundRequests(
      requestBody,
    );

    final productsApiResponse = refundRequestsApiResponseFromJson(response);

    if (response != null) {
      if (productsApiResponse.success ?? false) {
        setRefundsRequestList = productsApiResponse.data?.refunds ?? [];

        getRefundsRequestApiRequestLoader(false);
      } else {
        appToastView(title: productsApiResponse.message.toString());
      }
      getRefundsRequestApiRequestLoader(false);
    }
    getRefundsRequestApiRequestLoader(false);
  }

  // -----------------------------------
  // Create Refund API
  // -----------------------------------
  var createRefundApiRequestLoader = false.obs;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final Rx<Order> _selectedOrder = Order().obs;
  Order? get selectedOrder => _selectedOrder.value;

  void setSelectedOrder(Order order) {
    _selectedOrder.value = order;
  }

  Future<void> createRefundApiRequest() async {

    if (selectedOrder == Order()) {
      appToastView(title: 'Order is is required');
      return;
    }

    if (amountController.text.isEmpty) {
      appToastView(title: 'Refund amount is required');
      return;
    }

    if (descriptionController.text.isEmpty) {
      appToastView(title: 'Refund reason is required');
      return;
    }
    createRefundApiRequestLoader(true);

    final formData = dio.FormData.fromMap({
      "traveler_id":
          userPreferences.loggedInUserData.traveler?.getTravelerId() ?? '',
      "partner_id": selectedOrder?.partner?.getPartnerId() ?? '',
      "order_id": selectedOrder?.getOrderId(),
      "reason": selectedReason.toString(),
      "comments": descriptionController.text.toString(),
      "amount": amountController.text.toString(),
    });

    if (selectedImages.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'images[]',
          await dio.MultipartFile.fromFile(
            selectedImages[0].path,
            filename: 'images.jpg',
          ),
        ),
      );
    }

    var response = await RefundRepository.instance.createRefundRequest(
      formData,
    );

    final productsApiResponse = refundRequestsApiResponseFromJson(response);

    if (response != null) {
      if (productsApiResponse.success ?? false) {
        appToastView(title: productsApiResponse.message.toString());

        await getRefundsRequestApiRequest();
        Get.back();
        // setRefundsRequestList = productsApiResponse.data?.refunds ?? [];

        createRefundApiRequestLoader(false);
      } else {
        appToastView(
          title:
              productsApiResponse.errors?.getAllErrors() ??
              productsApiResponse.message.toString(),
        );
      }
      createRefundApiRequestLoader(false);
    }
    createRefundApiRequestLoader(false);
  }
}
