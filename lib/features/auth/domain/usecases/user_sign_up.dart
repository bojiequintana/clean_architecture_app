import 'package:fpdart/src/either.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/features/auth/domain/entities/user.dart';
import 'package:lending_app/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}
