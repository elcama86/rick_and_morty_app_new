part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LogoutRequest extends AuthEvent {}

class UserChanged extends AuthEvent {
  final User user;

  UserChanged(this.user);
}
