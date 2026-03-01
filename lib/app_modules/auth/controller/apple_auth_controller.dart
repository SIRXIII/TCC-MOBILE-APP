import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';

import 'auth_controller.dart';

class AppleAuthController extends GetxController {
  // 🔒 Private constructor for singleton
  AppleAuthController._privateConstructor();

  // 🔁 Single instance available globally
  static final AppleAuthController instance =
      AppleAuthController._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> signInWithApple() async {
    try {
      isLoading.value = true;

      final rawNonce = _generateNonce();
      final nonce = _sha256(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      AppLogger.debugPrintLogs(
        'Sign in with Apple - appleCredential',
        appleCredential.identityToken,
      );

      AuthController.instance.loginWithGoogleApiRequest(
        appleCredential.identityToken ?? '',
      );

      /*      final oauthCredential = OAuthProvider(
        "apple.com",
      ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

      final userCredential = await _auth.signInWithCredential(oauthCredential);

      final user = userCredential.user;

      // Save name/email first time only
      if (user != null && appleCredential.givenName != null) {
        await user.updateDisplayName(
          '${appleCredential.givenName} ${appleCredential.familyName}',
        );
      }

      AuthController.instance.loginWithGoogleApiRequest(user?.uid ?? '');*/
      // Navigate
      // Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Sign In Failed', e.toString());
      AppLogger.debugPrintLogs('Sign in with Apple - error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 🔐 Security Helpers
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}
