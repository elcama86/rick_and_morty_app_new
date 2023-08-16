part of 'auth_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AppStatus status;
  final User user;

  const AuthState._({
    required this.status,
    this.user = User.empty,
  });

  const AuthState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AppStatus.unauthenticated,
        );

  @override
  List<Object> get props => [status, user];
}
