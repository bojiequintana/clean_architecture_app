import 'package:get_it/get_it.dart';
import 'package:lending_app/core/common/cubit/app_user_cubit.dart';
import 'package:lending_app/core/secrets/app_secrets.dart';
import 'package:lending_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:lending_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:lending_app/features/auth/domain/repository/auth_repository.dart';
import 'package:lending_app/features/auth/domain/usecases/current_user.dart';
import 'package:lending_app/features/auth/domain/usecases/logout_user.dart';
import 'package:lending_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lending_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:lending_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    //Datasource
    ..registerFactory<AuthDatasource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignOut(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userSignout: serviceLocator(),
      ),
    );
}
