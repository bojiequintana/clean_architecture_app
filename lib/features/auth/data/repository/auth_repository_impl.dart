import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/exceptions.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/network/connection_checker.dart';
import 'package:lending_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:lending_app/core/common/entities/user.dart';
import 'package:lending_app/features/auth/data/models/user_model.dart';
import 'package:lending_app/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.authDatasource, this.connectionChecker);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await authDatasource.signInWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await authDatasource.signUpWithEmailPassword(
          name: name, email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No Internet Connection'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = authDatasource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(UserModel(
            id: session.user.id, email: session.user.email ?? '', name: ''));
      }
      final user = await authDatasource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final userStatus = await authDatasource.logout();
      if (!userStatus) {
        return left(Failure('User not logged in!'));
      }
      return right(userStatus);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
