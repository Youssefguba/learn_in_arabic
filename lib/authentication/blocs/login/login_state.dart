part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final PhoneNumber phoneNumber;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [phoneNumber, password, status];

  LoginState copyWith({
    PhoneNumber phoneNumber,
    Password password,
    FormzStatus status,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
