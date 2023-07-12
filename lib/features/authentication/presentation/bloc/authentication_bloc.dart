import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_3mc/core/constants/enums/auth_enum.dart';
import 'package:taks_3mc/features/authentication/domain/usecases/login_with_phone.dart';
import 'package:taks_3mc/features/authentication/domain/usecases/signup_with_phone.dart';
import 'package:taks_3mc/features/authentication/domain/usecases/verify_otp.dart';

import 'package:taks_3mc/injection_container.dart' as di;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.initial()) {
    on<AddPhoneNumberEvent>(_addPhoneNumber);
    on<SendCodeEvent>(_addVerification);
    on<SignInWithPhoneEvent>(_signInWithPhone);
    on<SignUpEvent>(_signUp);
    on<VerifyOtpEvent>(_verifyOtp);
  }

  FutureOr<void> _signInWithPhone(
      SignInWithPhoneEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(steps: AuthSteps.loading));
      if (state.phoneNumber.isNotEmpty) {
        await di
            .sl<LoginWithPhone>()
            .call(
              LoginWithPhoneParams(
                phoneNumber: state.phoneNumber,
                onCodeSend: (verificationId, id) {
                  add(SendCodeEvent(
                      verificationId: verificationId, isCodeSent: true));
                },
                onAutoVerify: (credentials) {},
                onFailed: (e) {},
                autoRetrieval: (auto) {},
              ),
            )
            .then((value) {
          if (!value) {
            emit(state.copyWith(errorType: AuthErrorEnum.notRegistered));
          }
        });
      }
    } catch (e) {
      return;
    }
  }

  FutureOr<void> _addPhoneNumber(
      AddPhoneNumberEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
        phoneNumber: event.phoneNumber, errorType: AuthErrorEnum.none));
  }

  FutureOr<void> _verifyOtp(
      VerifyOtpEvent event, Emitter<AuthenticationState> emit) async {
    if (event.verificationId.isNotEmpty && event.code.isNotEmpty) {
      final credentials = PhoneAuthProvider.credential(
          verificationId: event.verificationId, smsCode: event.code);
      final verification = await di
          .sl<VerifyOtp>()
          .call(VerifyOtpParams(credentials: credentials));
      if (verification) {
        emit(state.copyWith(
            steps: AuthSteps.loggedIn, errorType: AuthErrorEnum.none));
      } else {
        emit(state.copyWith(errorType: AuthErrorEnum.badCode));
      }
    }
  }

  FutureOr<void> _signUp(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    if (event.name.isNotEmpty) {
      await di.sl<SignupWithPhone>().call(SignupWithPhoneParams(
          phoneNumber: state.phoneNumber, name: event.name));
      add(SignInWithPhoneEvent());
    }
  }

  FutureOr<void> _addVerification(
      SendCodeEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
        userVerificationId: event.verificationId, steps: AuthSteps.codeSent));
  }
}
