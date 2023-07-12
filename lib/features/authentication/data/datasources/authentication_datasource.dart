import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationDatasource {
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

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<bool> loginWithPhone(
      String phoneNumber,
      Function(String value, int? value1) onCodeSend,
      Function(PhoneAuthCredential credential) onAutoVerify,
      Function(FirebaseAuthException value) onFailed,
      Function(String value) autoRetrieval) async {
    try {
      final user = await db.collection("users").doc(phoneNumber).get();
      if (user.get("name") == null) {
        return false;
      }
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: onAutoVerify,
        verificationFailed: onFailed,
        codeSent: onCodeSend,
        codeAutoRetrievalTimeout: autoRetrieval,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signupWithPhone(String phoneNumber, String name) async {
    try {
      await db.collection("users").doc(phoneNumber).set({'name': name});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signinWithCredential(PhoneAuthCredential credential) async {
    try {
      await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }
}
