import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:rick_and_morty_app/features/auth/domain/domain.dart';

class UserMapper {
  static User toUser(firebase_auth.User user) => User(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        imageUrl: user.photoURL ?? '',
      );
}
