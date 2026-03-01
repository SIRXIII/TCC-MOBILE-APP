// views/notifications_list_view.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/notifications/model/notification_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/notifications/model/notifications_api_response.dart';
import 'package:travel_clothing_club_flutter/utils/extensions/string+ext.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import '../controllers/notifications_controller.dart';
import '../../../../utils/app_imports.dart' hide Notification;

class TravelerNotificationsListView extends StatelessWidget {
  TravelerNotificationsListView({super.key});

  final NotificationsController controller =
      Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: appTextView(
          text: 'Notifications',
          color: AppColors.BLACK,
          size: AppDimensions.FONT_SIZE_18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          // isStroke: false,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgIconWidget(assetName: AppImages.icBack),
          ),
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.PRIMARY_COLOR,
        actions: [
          // // Mark All as Read
          // Obx(() {
          //   if (controller.unreadCount > 0) {
          //     return IconButton(
          //       icon: Icon(Icons.mark_email_read),
          //       onPressed: controller.markAllAsRead,
          //       tooltip: 'Mark all as read',
          //     );
          //   }
          //   return const SizedBox();
          // }),
          // // Clear All
          // Obx(() {
          //   if (controller.notifications.isNotEmpty) {
          //     return IconButton(
          //       icon: const Icon(Icons.clear_all),
          //       onPressed: _showClearAllDialog,
          //       tooltip: 'Clear all notifications',
          //     );
          //   }
          //   return const SizedBox();
          // }),
        ],
      ),
      body: Obx(() {
        if (controller.getNotificationsApiRequestLoader.value) {
          return appShimmerView();
        }

        if (controller.notificationsList.isEmpty) {
          return _buildEmptyState();
        }

        return _buildNotificationsList();
      }),
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
            'Loading notifications...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: AppColors.PRIMARY_COLOR,
          ),
          const SizedBox(height: 20),
          appTextView(
            text: 'No Notifications',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 8),
          Text(
            'No Notifications found yet',
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final unreadNotifications = controller.unReadNotifications;
    final readNotifications = controller.readNotifications;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (unreadNotifications.isNotEmpty) ...[
          _buildSectionHeader('New', unreadNotifications.length),
          const SizedBox(height: 12),
          ...unreadNotifications.map(
            (notification) =>
                _buildNotificationCard(notification, isUnread: true),
          ),
          const SizedBox(height: 24),
        ],

        // Read Notifications Section
        if (readNotifications.isNotEmpty) ...[
          _buildSectionHeader('Earlier', readNotifications.length),
          const SizedBox(height: 12),
          ...readNotifications.map(
            (notification) =>
                _buildNotificationCard(notification, isUnread: false),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        appTextView(
          text: title,
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.BLACK,
          fontWeight: FontWeight.bold,
        ),

        const SizedBox(width: 8),

        appTextView(
          text: '(${count.toString()})',
          size: AppDimensions.FONT_SIZE_12,
          fontFamily: 'Roboto',
          color: AppColors.TEXT_1,
        ),
      ],
    );
  }

  Widget _buildNotificationCard(
    Notification notification, {
    required bool isUnread,
  }) {
    return InkWell(
      onTap: () {
        debugPrint('_buildNotificationCard --> ');
        controller.updateNotificationsReadApiRequest(notification.getId());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isUnread
                ? AppColors.PRIMARY_COLOR.withValues(alpha: 0.1)
                : AppColors.WHITE,
            shape: BoxShape.rectangle,
            borderRadius: AppBorderRadius.BORDER_RADIUS_10,
            border: Border.all(
              color: isUnread
                  ? AppColors.PRIMARY_COLOR.withValues(alpha: 0.1)
                  : AppColors.WHITE,
              width: isUnread ? 2 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Type and Time
                Row(
                  children: [
                    // Notification Type Icon
                    // Container(
                    //   width: 24,
                    //   height: 24,
                    //   decoration: BoxDecoration(
                    //     color: _getNotificationColor(
                    //       notification.type,
                    //     ).withOpacity(0.1),
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Icon(
                    //     _getNotificationIcon(notification.type),
                    //     size: 14,
                    //     color: _getNotificationColor(notification.type),
                    //   ),
                    // ),
                    // const SizedBox(width: 8),
                    // Unread Indicator
                    if (isUnread) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    // Time
                    Text(
                      notification.createdAt?.toTimeAgo() ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: isUnread
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    // More Options
                    /* PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      onSelected: (value) =>
                          _handleNotificationAction(value, notification),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: isUnread ? 'mark_read' : 'mark_unread',
                          child: Row(
                            children: [
                              Icon(
                                isUnread
                                    ? Icons.mark_email_read
                                    : Icons.mark_email_unread,
                                size: 18,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(width: 8),
                              Text(isUnread ? 'Mark as read' : 'Mark as unread'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  notification.type ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    color: isUnread ? Colors.black87 : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  notification.data?.getMessage() ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnread
                        ? Colors.grey.shade700
                        : Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Colors.green;
      case NotificationType.promotion:
        return Colors.orange;
      case NotificationType.system:
        return Colors.blue;
      case NotificationType.reminder:
        return Colors.purple;
      case NotificationType.security:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_bag;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.system:
        return Icons.settings;
      case NotificationType.reminder:
        return Icons.notifications;
      case NotificationType.security:
        return Icons.security;
      default:
        return Icons.notifications;
    }
  }

  void _handleNotificationAction(
    String action,
    NotificationModel notification,
  ) {
    switch (action) {
      case 'mark_read':
        controller.markAsRead(notification.id);
        break;
      case 'mark_unread':
        controller.markAsUnread(notification.id);
        break;
      case 'delete':
        _showDeleteDialog(notification);
        break;
    }
  }

  void _showDeleteDialog(NotificationModel notification) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text(
          'Are you sure you want to delete this notification?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              // controller.deleteNotification(notification.id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text(
          'Are you sure you want to clear all notifications? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              // controller.clearAllNotifications();
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
