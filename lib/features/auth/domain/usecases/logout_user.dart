import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/features/auth/domain/repository/auth_repository.dart';

class UserSignOut implements Usecase<bool, NoParams> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
