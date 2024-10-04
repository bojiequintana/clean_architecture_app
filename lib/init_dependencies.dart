import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lending_app/core/common/cubit/app_user_cubit.dart';
import 'package:lending_app/core/network/connection_checker.dart';
import 'package:lending_app/core/secrets/app_secrets.dart';
import 'package:lending_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:lending_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:lending_app/features/auth/domain/repository/auth_repository.dart';
import 'package:lending_app/features/auth/domain/usecases/current_user.dart';
import 'package:lending_app/features/auth/domain/usecases/logout_user.dart';
import 'package:lending_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lending_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:lending_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lending_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:lending_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:lending_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:lending_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:lending_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:lending_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
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

void _initBlog() {
  //Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    //Usecases
    ..registerFactory(
      () => UploadBlogUsecase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogsUsecase(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => BlogBloc(
          uploadBlogUsecase: serviceLocator(),
          getAllBlogUsecase: serviceLocator()),
    );
}
