import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/core/common/entities/user.dart';
import 'package:lending_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
