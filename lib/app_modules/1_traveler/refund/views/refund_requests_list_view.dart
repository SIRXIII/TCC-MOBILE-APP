// views/refund_requests_list_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/models/refund_requests_api_response.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import '../controllers/refund_controller.dart';
import '../models/refund_request_model.dart';
import 'create_refund_request_view.dart';

class RefundRequestsListView extends StatefulWidget {
  const RefundRequestsListView({super.key});

  @override
  State<RefundRequestsListView> createState() => _RefundRequestsListViewState();
}

class _RefundRequestsListViewState extends State<RefundRequestsListView> {
  final RefundController controller = Get.find<RefundController>();

  /// --> initState
  @override
  void initState() {
    super.initState();

    controller.getRefundsRequestApiRequest();
  }

  /// --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'Refunds'),

      body: Obx(() {
        if (controller.getRefundsRequestApiRequestLoader.value) {
          return appShimmerView();
          return _buildLoadingState();
        }

        if (controller.refundRequestsList.isEmpty) {
          return _buildEmptyState();
        }

        return _buildRefundRequestsList();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateRefundRequestView()),
        backgroundColor: AppColors.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading refund requests...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.money_off, size: 80, color: AppColors.PRIMARY_COLOR),
            const SizedBox(height: 20),

            appTextView(
              text: 'No Refund Requests',
              size: AppDimensions.FONT_SIZE_16,
              fontFamily: 'Roboto',
              color: AppColors.BLACK,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 10),

            appTextView(
              text: 'You haven\'t submitted any refund requests yet',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Roboto',
              color: AppColors.TEXT_1,
              // fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRefundRequestsList() {
    final pendingRequests = controller.pendingRequests;
    final processedRequests = controller.processedRequests;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        // Pending Requests Section
        if (controller.refundRequestsList.isNotEmpty) ...[
          // _buildSectionHeader('Pending Review', pendingRequests.length),
          // const SizedBox(height: 12),
          ...controller.refundRequestsList.map(
            (request) => _buildRefundRequestCard(request),
          ),
          const SizedBox(height: 24),
        ],

        // Processed Requests Section
        // if (processedRequests.isNotEmpty) ...[
        //   _buildSectionHeader('Processed', processedRequests.length),
        //   const SizedBox(height: 12),
        //   ...processedRequests.map(
        //     (request) => _buildRefundRequestCard(request),
        //   ),
        // ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRefundRequestCard(Refund request) {
    return InkWell(
      onTap: () {
        controller.selectedRefund = request;
        Get.toNamed(AppRoutes.refundDetails);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Order ID and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppCacheImageView(
                      imageUrl: request.order!.items?[0].getImage() ?? '',
                      height: 70,
                      width: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: appTextView(
                        text: request.getRefundId(),
                        size: AppDimensions.FONT_SIZE_16,
                        fontFamily: 'Roboto',
                        color: AppColors.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Spacer(),
                    appTextView(
                      text: request.getRequestedAt(),
                      size: AppDimensions.FONT_SIZE_12,
                      fontFamily: 'Roboto',
                      color: AppColors.TEXT_1,
                      // fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.6, // Constrains the width
                      child: appTextView(
                        text: request.getReason(),
                        size: AppDimensions.FONT_SIZE_14,
                        fontFamily: 'Roboto',
                        color: AppColors.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: request.getStatusColor().withOpacity(0.1),
                        borderRadius: AppBorderRadius.BORDER_RADIUS_100,
                        border: Border.all(color: request.getStatusColor()),
                      ),
                      child: Text(
                        request.getStatus(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: request.getStatusColor(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                appTextView(
                  text: request.getRequestedAt(),
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  color: AppColors.TEXT_1,
                  // fontWeight: FontWeight.w600,
                ),

                // Images Preview
                // if (request.order?.items!.isNotEmpty) ...[
                //   SizedBox(
                //     height: 60,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: request.imageUrls.length,
                //       itemBuilder: (context, index) {
                //         return Container(
                //           width: 60,
                //           height: 60,
                //           margin: const EdgeInsets.only(right: 8),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             image: DecorationImage(
                //               image: AssetImage(request.imageUrls[index]),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                //   const SizedBox(height: 12),
                // ],

                // Footer with Date and Actions
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Submitted: ${_formatDate(request.createdAt)}',
                //       style: const TextStyle(fontSize: 12, color: Colors.grey),
                //     ),
                //     if (request.status == RefundStatus.pending)
                //       TextButton(
                //         onPressed: () => _showCancelDialog(request),
                //         child: const Text(
                //           'Cancel',
                //           style: TextStyle(color: Colors.red),
                //         ),
                //       ),
                //   ],
                // ),

                // Admin Note (if available)
                /*if (request.adminNote != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Admin Note:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request.adminNote!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showCancelDialog(RefundRequest request) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Refund Request'),
        content: const Text(
          'Are you sure you want to cancel this refund request?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.cancelRefundRequest(request.id);
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
