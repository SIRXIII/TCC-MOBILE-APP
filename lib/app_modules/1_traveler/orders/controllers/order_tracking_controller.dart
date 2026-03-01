import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/support/model/add_support_ticket_api_response.dart';
import 'package:travel_clothing_club_flutter/repositories/support_repository.dart';

import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';

class OrderTrackingController extends GetxController {
  // Order details
  // final RxMap<String, dynamic> orderDetails = <String, dynamic>{}.obs;

  // Tracking status
  final RxString currentStatus = 'confirmed'.obs;
  String get getCurrentStatus => currentStatus.value;
  void setCurrentStatus(String status) {
    currentStatus.value = status;
  }

  final RxDouble progressValue = 0.0.obs;

  // Driver location simulation
  final RxDouble driverLat = 0.0.obs;
  final RxDouble driverLng = 0.0.obs;

  // Estimated time
  final RxString estimatedArrival = '5 min'.obs;
  final RxString distanceToPickup = '1.2 km'.obs;

  // Timer for simulation
  Timer? _trackingTimer;

  // Tracking steps
  final List<Map<String, dynamic>> trackingSteps = [
    {
      'status': 'Pending',
      'title': 'Your order is Pending.',
      'description': 'Your ride has been confirmed',
      'icon': AppImages.icCheck,
      // 'icon': Icons.check_circle,
      'color': Colors.green,
      'time': AppGlobal.instance.getSelectedOrder.getPendingDate(),
    },
    {
      'status': 'Processing',
      'title': 'Your order is confirmed.',
      'description': 'Your ride has been confirmed',
      'icon': AppImages.icCheck,
      // 'icon': Icons.check_circle,
      'color': Colors.green,
      'time': AppGlobal.instance.getSelectedOrder.getPendingDate(),
    },
    // {
    //   'status': 'driver_assigned',
    //   'title': 'Driver Assigned',
    //   'description': 'Mike is on the way to pick you up',
    //   'icon': AppImages.icCheck,
    //   'color': Colors.blue,
    //   'time': '09:32 AM',
    // },
    // {
    //   'status': 'processing',
    //   'title': 'Partner is preparing your order.',
    //   'description': 'Mike is arriving at your location',
    //   'icon': AppImages.icCheck,
    //   'color': Colors.orange,
    //   'time': '09:38 AM',
    // },
    {
      'status': 'Shipped',
      'title': 'Picked Up',
      'description': 'You have been picked up',
      'icon': AppImages.icCheck,
      'color': Colors.purple,
      'time': AppGlobal.instance.getSelectedOrder.getDispatchTime(),
    },

    // {
    //   'status': 'Shipped',
    //   'title': 'Your order is out for delivery.',
    //   'description': 'Heading to your destination',
    //   'icon': AppImages.icCheck,
    //   'color': Colors.blue,
    //   'time': AppGlobal.instance.getSelectedOrder.getDispatchTime(),
    // },
    {
      'status': 'Delivered',
      'title': 'Delivered',
      'description': 'Ride completed successfully',
      'icon': AppImages.icCheck,
      'color': Colors.green,
      'time': AppGlobal.instance.getSelectedOrder.getDeliveryTime(),
    },
    {
      'status': 'Returned',
      'title': 'Returned',
      'description': 'Ride completed successfully',
      'icon': AppImages.icCheck,
      'color': Colors.green,
      'time': AppGlobal.instance.getSelectedOrder.getReturnTime(),
    },
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    // _initializeOrderDetails();

    AppLogger.debugPrintLogs(
      'Selected Order',
      AppGlobal.instance.getSelectedOrder.toString(),
    );

    setCurrentStatus(AppGlobal.instance.getSelectedOrder.getStatus());
    // _startTrackingSimulation();
  }

  @override
  void onClose() {
    _trackingTimer?.cancel();
    super.onClose();
  }

  int getCurrentStepIndex() {
    // debugPrint('getCurrentStepIndex --> ${getCurrentStatus}');
    return trackingSteps.indexWhere(
      (step) => step['status'] == getCurrentStatus,
    );
  }

  // Check if step is completed
  bool isStepCompleted(int index) {
    return index <= getCurrentStepIndex();
  }

  // Check if step is current
  bool isStepCurrent(int index) {
    return index == getCurrentStepIndex();
  }

  // Contact driver
  void contactDriver() {
    Get.snackbar(
      'Contact Driver',
      // 'Calling ${orderDetails['driver']['name']}...',
      'Calling ...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Cancel ride
  void cancelRide() {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Ride?'),
        content: const Text(
          'Are you sure you want to cancel this ride? A cancellation fee may apply.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Keep Ride'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Ride Cancelled',
                'Your ride has been cancelled',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange,
              );
              Get.back(); // Go back to orders list
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel Ride'),
          ),
        ],
      ),
    );
  }

  // Share ride details
  void shareRideDetails() {
    Get.snackbar(
      'Share Ride',
      'Ride details shared successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // -----------------------------------
  // Create Support Ticket API
  // -----------------------------------
  var addSupportTicketApiRequestLoader = false.obs;

  Future<void> addSupportTicketApiRequest(int orderId) async {
    debugPrint('addSupportTicketApiRequest --> ');

    addSupportTicketApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      "subject": 'Support Ticket',
      "message": 'Support Ticket',
      "order_id": orderId, // 'shipping', 'billing'
    };

    var response = await SupportRepository.instance.submitSupportTicket(
      requestBody,
    );

    final apiResponse = addSupportTicketApiResponseFromJson(response);

    if (response != null) {
      final data = apiResponse.data;
      if (data != null) {
        AppGlobal.instance.ticketId = data.getId();

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(AppRoutes.pusherChat);
        });
        addSupportTicketApiRequestLoader(false);
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      // appToastView(title: apiResponse.message.toString());
      addSupportTicketApiRequestLoader(false);
    }
    addSupportTicketApiRequestLoader(false);
  }
}
