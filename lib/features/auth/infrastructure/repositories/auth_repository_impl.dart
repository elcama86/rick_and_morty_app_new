import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) {
    return datasource.logInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<firebase_auth.UserCredential?> logInWithGoogle() {
    return datasource.logInWithGoogle();
  }

  @override
  Future<void> logOut() {
    return datasource.logOut();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return datasource.signUp(email: email, password: password);
  }

  @override
  Stream<User> get user => datasource.user;
  
  @override
  User get currentUser => datasource.currentUser;
}
