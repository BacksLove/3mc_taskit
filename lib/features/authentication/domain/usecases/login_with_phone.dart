import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taks_3mc/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/usecases/usecase.dart';

class LoginWithPhone extends UseCase<bool, LoginWithPhoneParams> {
  final AuthenticationRepository repository;

  LoginWithPhone(this.repository);

  @override
  Future<bool> call(LoginWithPhoneParams params) async {
    return await repository.loginWithPhone(
        params.phoneNumber,
        params.onCodeSend,
        params.onAutoVerify,
        params.onFailed,
        params.autoRetrieval);
  }
}

class LoginWithPhoneParams extends Equatable {
  final String phoneNumber;
  final Function(String value, int? value1) onCodeSend;
  final Function(PhoneAuthCredential credential) onAutoVerify;
  final Function(FirebaseAuthException value) onFailed;
  final Function(String value) autoRetrieval;

  const LoginWithPhoneParams(
      {required this.phoneNumber,
      required this.onCodeSend,
      required this.onAutoVerify,
      required this.onFailed,
      required this.autoRetrieval})
      : super();

  @override
  List<Object?> get props =>
      [phoneNumber, onCodeSend, onAutoVerify, onFailed, autoRetrieval];
}
