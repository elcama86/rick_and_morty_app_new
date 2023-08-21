import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class GoRouterNotifier extends ChangeNotifier {
  final AuthStatus status;

  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this.status) {
    authStatus = status;
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
