import 'package:equatable/equatable.dart';
import 'package:taks_3mc/core/usecases/usecase.dart';
import 'package:taks_3mc/features/authentication/domain/repositories/authentication_repository.dart';

class SignupWithPhone extends UseCase<bool, SignupWithPhoneParams> {
  final AuthenticationRepository repository;

  SignupWithPhone(this.repository);

  @override
  Future<bool> call(SignupWithPhoneParams params) async {
    return await repository.signupWithPhone(params.phoneNumber, params.name);
  }
}

class SignupWithPhoneParams extends Equatable {
  final String phoneNumber;
  final String name;

  const SignupWithPhoneParams({required this.phoneNumber, required this.name})
      : super();

  @override
  List<Object?> get props => [phoneNumber, name];
}
