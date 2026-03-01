// // controllers/support_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/support/model/support_request_model.dart';
//
// class SupportController extends GetxController {
//   // final RxList<SupportRequest> supportRequests = <SupportRequest>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isSubmitting = false.obs;
//
//   final List<String> categories = [
//     'account',
//     'billing',
//     'technical',
//     'rental',
//     'delivery',
//     'refund',
//     'other',
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     // _loadSupportRequests();
//   }
//
//
//   Future<void> submitSupportRequest({
//     required String subject,
//     required String description,
//     required String category,
//     required SupportPriority priority,
//   }) async {
//     if (subject.isEmpty || description.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please fill in all required fields',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     isSubmitting.value = true;
//
//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 2));
//
//     final newRequest = SupportRequest(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       subject: subject,
//       description: description,
//       createdAt: DateTime.now(),
//       status: SupportStatus.open,
//       priority: priority,
//       category: category,
//     );
//
//     supportRequests.insert(0, newRequest);
//     isSubmitting.value = false;
//
//     Get.back();
//     Get.snackbar(
//       'Success',
//       'Support request submitted successfully',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );
//   }
//
//   void updateRequestStatus(String requestId, SupportStatus newStatus) {
//     final index = supportRequests.indexWhere(
//       (request) => request.id == requestId,
//     );
//     if (index != -1) {
//       supportRequests[index] = supportRequests[index].copyWith(
//         status: newStatus,
//         updatedAt: DateTime.now(),
//       );
//     }
//   }
//
//   void deleteSupportRequest(String requestId) {
//     supportRequests.removeWhere((request) => request.id == requestId);
//     Get.snackbar(
//       'Deleted',
//       'Support request removed',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   List<SupportRequest> get openRequests {
//     return supportRequests
//         .where(
//           (request) =>
//               request.status == SupportStatus.open ||
//               request.status == SupportStatus.inProgress,
//         )
//         .toList();
//   }
//
//   List<SupportRequest> get resolvedRequests {
//     return supportRequests
//         .where(
//           (request) =>
//               request.status == SupportStatus.resolved ||
//               request.status == SupportStatus.closed,
//         )
//         .toList();
//   }
//
//   int get openRequestsCount {
//     return supportRequests
//         .where(
//           (request) =>
//               request.status == SupportStatus.open ||
//               request.status == SupportStatus.inProgress,
//         )
//         .length;
//   }
// }
