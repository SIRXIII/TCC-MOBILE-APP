class ApiConstant {
  static const String baseUrl = 'https://travelclothingclub-admin.online/api';

  // --> Traveler End Points
  static const String travelerRegister = '/traveler/register';
  static const String travelerLogin = '/traveler/login';
  static const String travelerUpdateFcmToken = '/traveler/update-fcm-token';
  static const String travelerUpdatePassword = '/traveler/update-password';

  static const String travelerForgotPassword = '/traveler/forgot-password';
  static const String travelerUpdateLocation = '/traveler/update-location';
  static const String travelerLogout = '/traveler/logout';
  static const String travelerProducts = '/traveler/products';
  static const String updateProfile = '/traveler/update-profile';
  static const String travelerFilterOptions =
      '/traveler/products/filter-options';
  static const String travelerProfile = '/traveler/me';
  static const String travelerCreateRefundRequest = '/traveler/refunds/request';
  static const String travelerRefundRequests = '/traveler/refunds';
  static const String travelerAddress = '/traveler/addresses';
  static const String deleteAddress = '/traveler/address/';
  static const String travelerToRiderRating = '/traveler/rate/rider';

  static const String riderToTravelerRating = '/rider/rate/traveler';

  // --> Rider End Points
  static const String riderLogin = '/rider/login';
  static const String riderUpdateFcmToken = '/rider/update-fcm-token';
  static const String riderLogout = '/rider/logout';
  static const String riderUpdateLocation = '/rider/update-location';
  static const String riderProfile = '/rider/me';
  static const String riderForgotPassword = '/rider/forgot-password';
  static const String riderUpdatePassword = '/rider/update-password';

  static const String login = '/login';
  static const String travelerLoginWithGoogle = '/traveler/auth/google/token';
  static const String riderLoginWithGoogle = '/rider/auth/google/token';

  // --> Order
  static const String placeOrder = '/traveler/orders';
  static const String ordersList = '/traveler/orders';
  static const String travelerRequestReturn =
      '/traveler/returns/schedule-pickup';

  static const String riderOrdersList = '/rider/orders';
  static const String riderUpdateOrderStatus = '/rider/update-oder-status';

  static const String notifications = '/notifications';
  static const String supportTickets = '/support-tickets';
  static const String supportTicketsMessages = '/support-tickets/messages';
}
