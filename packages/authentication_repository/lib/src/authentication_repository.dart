import 'dart:async';
import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'models/models.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the sign in with facebook process if a failure occurs.
class LogInWithFacebookFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  String _verificationCode = '';


  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserModel.empty] if the user is not authenticated.
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<UserCredential> logInWithGoogle() async {
    try {

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      // print('this is google auth (1) ${googleAuth.accessToken}');
      // print('this is google auth (2) ${googleAuth.idToken}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      developer.log('this is a credential id token ${credential.idToken}');
      developer.log('this is a credential access token ${credential.accessToken}');
      developer.log('this is a credential secret ${credential.secret}');
      developer.log('this is a credential tokeen ${credential.token}');


      return await _firebaseAuth.signInWithCredential(credential);
    } catch(e) {
      print('print($e)');
      return null;
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [UserModel.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  /// Sign In With Phone Mobile Auth
  Future<bool> loginInWithMobileNumber(String mobileNo) async {
    try {
      int forceResendToken;

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: (authCredential) =>
            phoneVerificationCompleted(authCredential),
        verificationFailed: (authException) =>
            phoneVerificationFailed(authException),
        codeSent: (verificationId, [code]) =>
            phoneCodeSent(verificationId, [code]),
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
        forceResendingToken: forceResendToken,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  phoneVerificationCompleted(AuthCredential authCredential) async {}

  phoneVerificationFailed(FirebaseException authException) {
    print('Error of Phone Verification ${authException.message}');
  }

  phoneCodeAutoRetrievalTimeout(String verificationCode) {
    this._verificationCode = verificationCode;
  }

  phoneCodeSent(String verificationCode, List<int> code) {
    this._verificationCode = verificationCode;
  }


  /// Verify SMS Sent Code.
  Future<UserCredential> verifySmsCode(String smsCode) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationCode, smsCode: smsCode);
      return await _firebaseAuth.signInWithCredential(authCredential);
    } catch (e) {
      print(e);
      return null;
    }
  }


  /// Sign In With Facebook
  // Future<void> signInWithFacebook() async {
  //   try {
  //     // Trigger the sign-in flow
  //     final AccessToken result = await FacebookAuth.instance.login();
  //
  //     // Create a credential from the access token
  //     final FacebookAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(result.token);
  //
  //     // Once signed in, return the UserCredential
  //     await _firebaseAuth.signInWithCredential(facebookAuthCredential);
  //   } on Exception {
  //     throw LogInWithFacebookFailure();
  //   }
  // }
}

extension on User {
  UserModel get toUser {
    return UserModel(
        userId: uid,
        userEmail: email,
        phoneNumber: phoneNumber,
        username: displayName,
        photoURL: photoURL);
  }
}
