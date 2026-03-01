// class PusherConfig {
//   static const String apiKey = 'YOUR_PUSHER_KEY';
//   static const String cluster = 'YOUR_CLUSTER';
// }

class PusherConfig {
  // 🔑 Pusher credentials
  static const String appId = '2095894'; // backend only
  static const String apiKey = 'fef5236eae31334c912c';
  static const String secret = '3b495e75ca7c66cd1f1f'; // backend only
  static const String cluster = 'us3';

  // 🔐 Channel options
  static const bool encrypted = true;
  static const bool enableLogging = true;

  // 📡 Channel names
  static String supportTicketChannel(int ticketId) =>
      'support.ticket.$ticketId';

  static String presenceOrderChannel(String orderId) =>
      'presence-order-$orderId';

  // 🎯 Event names
  static const String newMessageEvent = 'new-message';
  static const String typingEvent = 'typing';
  static const String statusEvent = 'status-update';

  // 🌐 Auth (required for private/presence channels)
  static const String authEndpoint = 'https://yourdomain.com/broadcasting/auth';

  static const Map<String, String> authHeaders = {
    'Accept': 'application/json',
    // 'Authorization': 'Bearer YOUR_TOKEN'  // set dynamically
  };

  // 🧪 Debug helpers
  static bool get isDebug => true;
}
