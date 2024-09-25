import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lending_app/core/common/cubit/app_user_cubit.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/core/common/entities/user.dart';
import 'package:lending_app/features/auth/domain/usecases/current_user.dart';
import 'package:lending_app/features/auth/domain/usecases/logout_user.dart';
import 'package:lending_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lending_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserSignOut _userSignout;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignout,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userSignout = userSignout,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // on<AuthEvent>((_, emit) {
    //   if (emit is! AuthSignOut) emit(AuthLoading());
    // });
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignOut>(_onUserSignOut);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));
    res.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    res.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onUserSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final res = await _userSignout(NoParams());
    res.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (r) => _appUserCubit.updateUser(null),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
