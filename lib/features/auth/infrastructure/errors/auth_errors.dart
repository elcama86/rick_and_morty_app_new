class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;
  const SignUpWithEmailAndPasswordFailure({
    this.message = 'unknown_error_message',
  });

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'invalid_email',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'user_disabled',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'email_already_use',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'operation_not_allowed',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'weak_password',
        );
      case 'network-request-failed':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'no_internet',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;
  const LogInWithEmailAndPasswordFailure({
    this.message = 'unknown_error_message',
  });

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          message: 'invalid_email',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          message:
              'user_disabled',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          message: 'user_not_found',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          message: 'wrong_password',
        );
      case 'network-request-failed':
        return const LogInWithEmailAndPasswordFailure(
          message: 'no_internet',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure({
    this.message = 'unknown_error_message',
  });

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          message: 'account_exists',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          message: 'invalid_credential',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          message: 'operation_not_allowed',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          message:
              'user_disabled',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          message: 'user_not_found',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          message: 'wrong_password',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          message: 'invalid_code',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          message: 'invalid_id',
        );
      case 'network-request-failed':
        return const LogInWithGoogleFailure(
          message: 'no_internet',
        );
      case 'network_error':
        return const LogInWithGoogleFailure(
          message: 'no_internet',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
}

class LogOutFailure implements Exception {}
