import 'package:firebase_auth/firebase_auth.dart';
import 'package:taks_3mc/core/util/network.dart';
import 'package:taks_3mc/features/authentication/data/datasources/authentication_datasource.dart';
import 'package:taks_3mc/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  NetworkInfo networkInfo;
  AuthenticationDatasource datasource;

  AuthenticationRepositoryImpl(this.networkInfo, this.datasource);

  @override
  Future<bool> loginWithPhone(
      String phoneNumber,
      Function(String value, int? value1) onCodeSend,
      Function(PhoneAuthCredential credential) onAutoVerify,
      Function(FirebaseAuthException value) onFailed,
      Function(String value) autoRetrieval) async {
    await networkInfo.isConnected;

    final loginWithPhone = datasource.loginWithPhone(
        phoneNumber, onCodeSend, onAutoVerify, onFailed, autoRetrieval);

    return loginWithPhone;
  }

  @override
  Future<bool> signinWithCredential(PhoneAuthCredential credential) async {
    await networkInfo.isConnected;

    final signinWithCredential = datasource.signinWithCredential(credential);
    return signinWithCredential;
  }

  @override
  Future<bool> signupWithPhone(String phoneNumber, String name) async {
    await networkInfo.isConnected;

    final signupWithPhone = datasource.signupWithPhone(phoneNumber, name);
    return signupWithPhone;
  }
}
