import 'dart:math';

class GuestUserGenerator {
  static final _random = Random();

  static String _randomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(
      length,
      (_) => chars[_random.nextInt(chars.length)],
    ).join();
  }

  static Map<String, String> generate() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = _randomString(5);

    final email = 'guest_$timestamp$randomPart@app.com';
    final password = 'Guest@${_randomString(8)}';

    return {
      'name': 'Guest User',
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
  }
}
