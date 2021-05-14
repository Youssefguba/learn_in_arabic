import 'dart:async';
import 'package:authentication_repository/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository, this._userRepository)
      : assert(_authenticationRepository != null),
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  /// Login with Phone Number
  Future<void> logInWithPhoneNumber(String phoneNumber) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.loginInWithMobileNumber(phoneNumber);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }


  /// Add User to Firestore DB.
  Future<void> addUserToFirestore(
      {String username, String email, String phoneNumber}) async {
    await _userRepository.addUserToFirestore(UserModel(
      username: username,
      userEmail: email,
      phoneNumber: phoneNumber,
      photoURL: null,
    ));
  }

  /// Login with Phone Number
  Future<UserCredential> verifySmsCode(String codeSent) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return await _authenticationRepository.verifySmsCode(codeSent);
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return null;
    }
  }

  /// Login With Google
  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      UserCredential _signedUser =
          await _authenticationRepository.logInWithGoogle();
      _userRepository.addUserToFirestore(UserModel(
        userId: _signedUser.user.uid,
        userEmail: _signedUser.user.email,
        username: _signedUser.user.displayName,
        photoURL: _signedUser.user.photoURL,
        loggedInVia: _signedUser.credential.signInMethod,
        tokenId: _signedUser.credential.token,
      ),
        socialUid: _signedUser.user.uid
      );

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      print('Google Login Failed');
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
      print('Google Login NoSuchMethodError');
    }
  }

  // Future<void> signInWithFacebook() async {
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //   try {
  //     await _authenticationRepository.signInWithFacebook();
  //   } on Exception {
  //     print('Facebook Login Failed');
  //   } on NoSuchMethodError {
  //     print('Facebook Login NoSuchMethodError');
  //   }
  // }
}
