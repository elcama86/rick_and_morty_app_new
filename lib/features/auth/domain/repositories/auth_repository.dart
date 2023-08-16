import '../entities/user.dart';

abstract class AuthRepository {
  Stream<User> get user;
  User get currentUser;
  Future<void> signUp({required String email, required String password});
  Future<void> logInWithGoogle();
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> logOut();
}
