part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AddPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;

  const AddPhoneNumberEvent({required this.phoneNumber});
}

class SendCodeEvent extends AuthenticationEvent {
  final bool isCodeSent;
  final String verificationId;

  const SendCodeEvent({required this.verificationId, required this.isCodeSent});
}

class SignUpEvent extends AuthenticationEvent {
  final String name;

  const SignUpEvent({required this.name});
}

class SignInWithPhoneEvent extends AuthenticationEvent {}

class VerifyOtpEvent extends AuthenticationEvent {
  final String code;
  final String verificationId;

  const VerifyOtpEvent({required this.code, required this.verificationId});
}
