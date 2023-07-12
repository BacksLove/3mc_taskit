import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<bool> loginWithPhone(
    String phoneNumber,
    Function(String value, int? value1) onCodeSend,
    Function(PhoneAuthCredential credential) onAutoVerify,
    Function(FirebaseAuthException value) onFailed,
    Function(String value) autoRetrieval,
  );
  Future<bool> signupWithPhone(String phoneNumber, String name);
  Future<bool> signinWithCredential(PhoneAuthCredential credential);
}
