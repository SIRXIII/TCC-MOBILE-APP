// routes/app_pages.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/bindings/address_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/views/add_address_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/views/address_list_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/bindings/filter_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/views/sheets/filter_bottom_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/cart/bindings/cart_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/cart/views/cart_list_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/chat/bindings/chat_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/chat/views/chat_conversation_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/dashboard/bindings/traveler_dashboard_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/dashboard/views/traveler_dashboard_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/views/product_details_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/notifications/bindings/notifications_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/notifications/view/traveler_notifications_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/bindings/traveler_orders_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/views/order_tracking_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/profile/views/traveler_edit_profile_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/bindings/refund_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/views/create_refund_request_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/views/refund_details_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/views/refund_requests_list_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/dashboard/views/rider_dashboard_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/bindings/deliveries_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/views/deliveries_details_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/bindings/rider_support_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/bindings/auth_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/views/ProfileSetupView.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/views/change_password_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/views/login_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/views/sign_up_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/chat/binding/order_chat_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/chat/views/order_chat_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/location/views/add_manual_location_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/location/views/location_permission_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/on_boarding/bindings/onboarding_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/on_boarding/views/onboarding_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/binding/pusher_chat_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/views/pusher_chat_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/bindings/account_type_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/views/account_type_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/splash/bindings/splash_binding.dart';
import 'package:travel_clothing_club_flutter/app_modules/splash/views/splash_view.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/utils/constants/firebase_constants.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.accountType,
      page: () => AccountTypeView(),
      binding: AccountTypeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.locationPermission,
      page: () => LocationPermissionView(),
    ),

    GetPage(
      name: AppRoutes.addManualLocationView,
      page: () => AddManualLocationView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes.profileSetup,
      page: () => ProfileSetupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.travelerEditProfile,
      page: () => TravelerEditProfileView(),
      binding: AuthBinding(),
    ),

    // --> Traveler
    GetPage(
      name: AppRoutes.travelerDashboard,
      page: () => TravelerDashboardView(),
      bindings: [
        AuthBinding(),
        TravelerDashboardBinding(),
        TravelerHomeBinding(),
        AddressBinding(),
        CartBinding(),
        TravelerOrdersBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.riderDeliveriesDetails,
      page: () => DeliveriesDetailsView(),
    ),

    GetPage(
      name: AppRoutes.travelerNotifications,
      page: () => TravelerNotificationsListView(),
      binding: NotificationsBinding(),
    ),

    // --> Rider
    GetPage(
      name: AppRoutes.riderDashboard,
      page: () => RiderDashboardView(),
      bindings: [
        DeliveriesBinding(),
        AddressBinding(),
        AuthBinding(),
        // ChatBinding(),
        RiderSupportBinding(),
      ],
    ),
    GetPage(name: AppRoutes.orderTracking, page: () => OrderTrackingView()),

    GetPage(name: AppRoutes.productDetail, page: () => ProductDetailsView()),

    GetPage(
      name: AppRoutes.refundRequests,
      page: () => RefundRequestsListView(),
      binding: RefundBinding(),
    ),
    GetPage(
      name: AppRoutes.createRefundRequest,
      page: () => CreateRefundRequestView(),
      binding: RefundBinding(),
    ),

    GetPage(name: AppRoutes.refundDetails, page: () => RefundDetailsView()),

    GetPage(
      name: AppRoutes.filter,
      page: () => FilterBottomSheet(),
      binding: FilterBinding(),
    ),

    GetPage(
      name: AppRoutes.addressList,
      page: () => AddressListView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => AddAddressView(),
      binding: AddressBinding(),
    ),

    GetPage(
      name: AppRoutes.cart,
      page: () => CartListView(),
      binding: CartBinding(),
    ),

    GetPage(
      name: AppRoutes.travelerChat,
      page: () {
        // Get parameters from route
        final parameters = Get.parameters;
        final receiverId = parameters[FirebaseConstants.receiverId] ?? '';
        final titleName = parameters[FirebaseConstants.receiverName] ?? '';
        return ChatConversationView(
          receiverId: receiverId,
          titleName: titleName,
        );
      },
      binding: TravelerChatBinding(),
    ),

    GetPage(
      name: AppRoutes.travelerChat,
      page: () {
        // Get parameters from route
        final parameters = Get.parameters;
        final receiverId = parameters[FirebaseConstants.receiverId] ?? '';
        final titleName = parameters[FirebaseConstants.receiverName] ?? '';
        return ChatConversationView(
          receiverId: receiverId,
          titleName: titleName,
        );
      },
      binding: TravelerChatBinding(),
    ),

    GetPage(
      name: AppRoutes.pusherChat,
      page: () {
        return PusherChatView();
      },
      binding: PusherChatBinding(),
    ),

    GetPage(
      name: AppRoutes.orderChat,

      page: () {
        // Get parameters from route
        final parameters = Get.parameters;
        final receiverId = parameters[FirebaseConstants.receiverId] ?? '';
        // final titleName = parameters[FirebaseConstants.receiverName] ?? '';
        final orderId = parameters[FirebaseConstants.orderId] ?? '';
        return OrderChatView(
          orderId: orderId,
          receiverId: receiverId,
          currentUserId:
              UserPreferences.instance.selectedUserType ==
                  AccountTypeEnum.traveler
              ? UserPreferences.instance.loggedInUserData.traveler?.getId() ??
                    ''
              : UserPreferences.instance.loggedInUserData.rider?.getId() ?? '',
          // titleName: titleName,
        );
      },

      binding: OrderChatBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.travelerChatList,
    //   page: () => ChatListView(),
    //   binding: TravelerChatBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.chatSupport,
    //   page: () => ChatSupportView(),
    //   binding: ChatBinding(),
    // ),

    // Add to your AppPages
    // GetPage(
    //   name: AppRoutes.supportRequests,
    //   page: () => SupportRequestsListView(),
    //   binding: SupportBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.createSupportRequest,
    //   page: () => CreateSupportRequestView(),
    //   binding: SupportBinding(),
    // ),
    GetPage(name: AppRoutes.changePassword, page: () => ChangePasswordView()),
  ];
}
