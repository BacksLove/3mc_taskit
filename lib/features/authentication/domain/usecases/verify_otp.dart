import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taks_3mc/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/usecases/usecase.dart';

class VerifyOtp extends UseCase<bool, VerifyOtpParams> {
  final AuthenticationRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<bool> call(VerifyOtpParams params) async {
    return await repository.signinWithCredential(params.credentials);
  }
}

class VerifyOtpParams extends Equatable {
  final PhoneAuthCredential credentials;

  const VerifyOtpParams({required this.credentials}) : super();

  @override
  List<Object?> get props => [credentials];
}
