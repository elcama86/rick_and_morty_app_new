import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/auth/domain/domain.dart';
import 'package:rick_and_morty_app/features/auth/infrastructure/infrastructure.dart';
import 'package:rick_and_morty_app/firebase_options.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authServices;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({required this.authServices}) : super(const AuthState._()) {
    _chekAuthStatus().then((_) {
      on<UserChanged>(_onUserChanged);
      on<LogoutRequest>(_onLogoutRequested);

      _userSubscription = authServices.user.listen(
        (user) => add(
          UserChanged(user),
        ),
      );
    });
  }

  Future<void> _chekAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    authServices.currentUser.isNotEmpty
        ? AuthState.authenticated(authServices.currentUser)
        : const AuthState.unauthenticated();
  }

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(LogoutRequest event, Emitter<AuthState> emit) async {
    emit(
      const AuthState.loading(),
    );

    await authServices.logOut();
  }

  static Future<void> initializeServices() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final authRepository = AuthRepositoryImpl(AuthDatasourceImpl());
    await authRepository.user.first;
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
