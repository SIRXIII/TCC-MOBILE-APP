import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class GoogleAuthController extends GetxController {
  // 🔒 Private constructor for singleton
  GoogleAuthController._privateConstructor();

  // 🔁 Single instance available globally
  static final GoogleAuthController instance =
      GoogleAuthController._privateConstructor();

  var isLoading = false.obs;

  // -----------------------------------
  // loginWithGoogle
  // -----------------------------------

  Future<void> loginWithGoogle() async {

    try {
      isLoading(true);
      // Trigger the authentication flow
      // String? token = await FirebaseMessaging.instance.getToken() ?? '';
      // print('loginWithGoogle --> FCM Token: $token');
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"],
      ).signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      // Create a new credential
      // debugPrint('loginWithGoogle -->  google id ${googleAuth.idToken}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential).then((
        value,
      ) async {
        var user = FirebaseAuth.instance.currentUser;


        AuthController.instance.loginWithGoogleApiRequest(
          googleAuth.accessToken ?? '',
        );
        /*
        String fullName =
            "${user!.displayName!.split(' ').first} ${user.displayName!.split(' ').last}";
        Map<String, String> data = {
          'name': fullName,
          'email': user.email.toString(),
          'google_id': user.uid,
          // 'platform': SocialLoginType.google.name,
          'token': token ?? '',
        };*/

        isLoading(false);
      });
    } catch (e) {
      appToastView(title: e.toString());

      isLoading(false);
    }
  }

  // -----------------------------------
  // loginWithApple
  // -----------------------------------
  // late final FirebaseAuth? _firebaseAuth;

  // Stream<User?> get authStateChanges => _firebaseAuth!.authStateChanges();

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginWithApple() async {
    FirebaseAuth.instance.signOut().then((value) async {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      try {
        // Request credential for the currently signed in Apple account.
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );


        // Create an `OAuthCredential` from the credential returned by Apple.
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        );

        // Sign in the user with Firebase. If the nonce we generated earlier does
        // not match the nonce in `appleCredential.identityToken`, sign in will fail.
        final authResult = await _auth.signInWithCredential(oauthCredential);

        final displayName =
            '${appleCredential.givenName} ${appleCredential.familyName}';



        final fixDisplayNameFromApple = [
          appleCredential.givenName ?? 'Guest',
          appleCredential.familyName ?? '',
        ].join(' ').trim();

        // ... once the authentication is complete

        if (_auth.currentUser?.displayName == null) {
          await _auth.currentUser?.updateDisplayName(fixDisplayNameFromApple);
          _auth.currentUser?.reload();
        }

        // TODO: HIT API
        /*providerSocialLogin(
            firstName: appleCredential.givenName ?? 'Guest',
            lastName: appleCredential.familyName ?? ' -',
            socialType: '4',
            email: _auth.currentUser?.email ?? '',
            phone: '');*/
      } catch (e) {

        // providerSocialLogin(
        //     firstName:'',
        //     lastName: '',
        //     socialType: '4',
        //     email: '',
        //     phone: '');
        // print(exception);
      }
      return null;
    });
    return null;
  }
}

class User {
  final String userId;
  final String name;

  final String? email;
  final String? profilePicture;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
  });
}

class SessionController {
  User? _user;

  User? get user => _user;

  void updateUser(User? user) {
    _user = user;
  }
}
