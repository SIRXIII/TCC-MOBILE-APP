// routes/app_routes.dart
// routes/app_routes.dart
class AppRoutes {
  // Prevent instantiation
  AppRoutes._();

  // Route names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String accountType = '/account-type';
  static const String login = '/login';
  static const String signup = '/signup';

  // --> Traveler Routes
  static const String travelerDashboard = '/traveler-dashboard';
  // static const String TravelerEditProfileView = '/traveler-dashboard';
  static const String travelerEditProfile = '/traveler/edit-profile';
  static const String travelerNotifications = '/traveler/notifications';
  static const String refundRequests = '/traveler/refund-requests';
  static const String createRefundRequest = '/traveler/create-refund-request';
  static const String refundDetails = '/traveler/refund-details';
  static const String travelerChat = '/traveler/chat';
  static const String travelerChatList = '/traveler/chat-list';

  // --> Rider
  static const String riderDashboard = '/rider-dashboard';
  static const String riderDeliveriesDetails = '/rider-deliveries-details';

  static const String locationPermission = '/location-permission';
  static const String addManualLocationView = '/add-manual-location';
  static const String profile = '/profile';
  static const String profileSetup = '/profile-setup';
  static const String settings = '/settings';
  static const String orderTracking = '/order-tracking';
  static const String productDetail = '/product-detail';
  static const String filter = '/filters';

  // static const String chatSupport = '/chat-support';

  // static const String supportRequests = '/support-requests';
  // static const String createSupportRequest = '/create-support-request';

  static const String cart = '/cart';

  static const String addressList = '/address-list';
  static const String addAddress = '/add-address';
  static const String changePassword = '/change-password';

  static const String orderChat = '/order-chat';

  static const String pusherChat = '/pusher-chat';
  // static const String changePassword = '/change-password';

  // Route parameters
  static const String paramUserId = 'userId';
  static const String paramOrderId = 'orderId';
  static const String paramRideId = 'rideId';

  // Route groups for organization
  static const List<String> authRoutes = [login, signup];
  static const List<String> mainRoutes = [
    travelerDashboard,
    riderDashboard,
    profile,
    settings,
  ];
  static const List<String> onboardingRoutes = [onboarding, accountType];

  // Helper methods for route generation with parameters
  static String travelerDashboardWithParam({String? userId}) {
    return _buildRouteWithParams(travelerDashboard, {paramUserId: userId});
  }

  static String riderDashboardWithParam({String? userId}) {
    return _buildRouteWithParams(riderDashboard, {paramUserId: userId});
  }

  static String profileWithParam(String userId) {
    return _buildRouteWithParams(profile, {paramUserId: userId});
  }

  // Generic method to build routes with parameters
  static String _buildRouteWithParams(
    String route,
    Map<String, String?> params,
  ) {
    final validParams = params..removeWhere((key, value) => value == null);

    if (validParams.isEmpty) return route;

    final paramsString = validParams.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    return '$route?$paramsString';
  }

  // Method to extract parameters from route
  static Map<String, String> getRouteParameters(String route) {
    final uri = Uri.parse(route);
    return uri.queryParameters;
  }

  // Method to get clean route without parameters
  static String getCleanRoute(String route) {
    final uri = Uri.parse(route);
    return uri.path;
  }

  // Initial route logic
  static String getInitialRoute() {
    // Add your logic here to determine the initial route
    // For example, check if user is logged in, onboarding completed, etc.
    return splash;
  }

  // Check if route requires authentication
  static bool requiresAuthentication(String route) {
    return mainRoutes.contains(getCleanRoute(route));
  }

  // Check if route is part of onboarding flow
  static bool isOnboardingRoute(String route) {
    return onboardingRoutes.contains(getCleanRoute(route));
  }
}
