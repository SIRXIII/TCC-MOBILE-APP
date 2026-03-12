// class PusherConfig {
//   static const String apiKey = 'YOUR_PUSHER_KEY';
//   static const String cluster = 'YOUR_CLUSTER';
// }

class PusherConfig {
  // Pusher credentials - load from environment variables
  static const String appId = String.fromEnvironment('PUSHER_APP_ID', defaultValue: '');
  static const String apiKey = String.fromEnvironment('PUSHER_APP_KEY', defaultValue: '');
  static const String secret = String.fromEnvironment('PUSHER_SECRET', defaultValue: ''); // backend only
  static const String cluster = String.fromEnvironment('PUSHER_CLUSTER', defaultValue: 'us3');

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
