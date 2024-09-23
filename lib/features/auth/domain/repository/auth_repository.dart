import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> currentUser();
}
