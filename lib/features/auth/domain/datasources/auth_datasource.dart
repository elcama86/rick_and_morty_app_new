import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../entities/user.dart';

abstract class AuthDatasource {
  Stream<User> get user;
  User get currentUser;
  Future<void> signUp({required String email, required String password});
  Future<firebase_auth.UserCredential?> logInWithGoogle();
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> logOut();
}
