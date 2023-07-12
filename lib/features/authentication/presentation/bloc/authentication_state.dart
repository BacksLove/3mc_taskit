// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final String smsCode;
  final AuthSteps steps;
  final String phoneNumber;
  final String name;
  final String userVerificationId;
  final AuthErrorEnum errorType;

  const AuthenticationState({
    required this.smsCode,
    required this.steps,
    required this.phoneNumber,
    required this.name,
    required this.userVerificationId,
    required this.errorType,
  });

  factory AuthenticationState.initial() => const AuthenticationState(
        smsCode: "",
        steps: AuthSteps.initial,
        phoneNumber: "",
        name: "",
        userVerificationId: "",
        errorType: AuthErrorEnum.none,
      );

  @override
  List<Object> get props =>
      [smsCode, steps, phoneNumber, name, userVerificationId, errorType];

  AuthenticationState copyWith({
    String? smsCode,
    AuthSteps? steps,
    String? phoneNumber,
    String? name,
    String? userVerificationId,
    AuthErrorEnum? errorType,
  }) {
    return AuthenticationState(
      smsCode: smsCode ?? this.smsCode,
      steps: steps ?? this.steps,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      userVerificationId: userVerificationId ?? this.userVerificationId,
      errorType: errorType ?? this.errorType,
    );
  }
}
