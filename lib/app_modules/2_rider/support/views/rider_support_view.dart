import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/controllers/support_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/views/create_rider_support_ticket_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/support/model/support_ticket_api_response.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';

class RiderSupportView extends StatefulWidget {
  const RiderSupportView({super.key});

  @override
  State<RiderSupportView> createState() => _RiderSupportViewState();
}

class _RiderSupportViewState extends State<RiderSupportView> {
  final RiderSupportController supportController =
      Get.find<RiderSupportController>();

  final AppGlobal _appGlobal = AppGlobal.instance;

  /// --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // appBar: appBarView(title: 'Address'),
      body: Obx(
        () => supportController.getSupportTicketsApiRequestLoader.isTrue
            ? appShimmerView()
            : supportController.supportTicketsList.isEmpty
            ? _buildEmptyState()
            : _buildSupportTicketList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          supportController.resetData();

          Get.to(() => CreateRiderSupportTicketView());
        },
        backgroundColor: AppColors.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.support_agent, size: 80, color: AppColors.PRIMARY_COLOR),
          const SizedBox(height: 20),

          appTextView(
            text: 'No Support Ticket Yet',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              supportController.resetData();

              Get.to(() => CreateRiderSupportTicketView());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.PRIMARY_COLOR,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: const Text('Create Support Ticket'),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportTicketList() {
    final data = supportController.supportTicketsList.reversed.toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...data.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                // child: _buildAddressCard(address, isDefault: false),
                child: _buildRefundRequestCard(item),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRefundRequestCard(SupportTicketModel data) {
    return InkWell(
      onTap: () {
        debugPrint('onTap --> ${data.orderId}');

        if (data.orderId != null) {
          _appGlobal.chatWith = 'Partner';
        } else {
          _appGlobal.chatWith = 'Admin';
        }

        _appGlobal.orderId = data.getOrderId().toString();
        _appGlobal.ticketId = data.id ?? 0;
        _appGlobal.chatWithName = 'Support Chat';

        Get.toNamed(AppRoutes.pusherChat);

        // controller.selectedRefund = request;
        // Get.toNamed(AppRoutes.refundDetails);
      },
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
            spacing: 8,
            children: [
              Row(
                children: [
                  appTextView(
                    text: data.getTicketId(),
                    size: AppDimensions.FONT_SIZE_16,
                    fontFamily: 'Roboto',
                    color: AppColors.BLACK,
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: data.getStatusColor().withOpacity(0.1),
                      borderRadius: AppBorderRadius.BORDER_RADIUS_100,
                      border: Border.all(color: data.getStatusColor()),
                    ),
                    child: Text(
                      data.getStatus(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: data.getStatusColor(),
                      ),
                    ),
                  ),
                ],
              ),

              appTextView(
                text: data.getSubject(),
                size: AppDimensions.FONT_SIZE_14,
                fontFamily: 'Roboto',
                color: AppColors.BLACK,
                fontWeight: FontWeight.w600,
              ),
              // Header with Order ID and Status
              appTextView(
                text: data.getReason(),
                size: AppDimensions.FONT_SIZE_12,
                fontFamily: 'Roboto',
                color: AppColors.TEXT_1,
                // fontWeight: FontWeight.w500,
              ),

              const SizedBox(height: 8),
              appTextView(
                text: data.getRequestedAt(),
                size: AppDimensions.FONT_SIZE_12,
                fontFamily: 'Roboto',
                color: AppColors.TEXT_1,
                // fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
