class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;
  const SignUpWithEmailAndPasswordFailure({
    this.message = 'Ha ocurrido un error desconocido.',
  });

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'El correo electrónico no es válido o está mal formateado.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'Este usuario ha sido deshabilitado. Por favor, contacte a soporte.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'Ya existe una cuenta registrada con ese correo electrónico.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Operación no permitida.  Por favor, contacte a soporte.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Por favor, ingrese una contraseña más segura.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;
  const LogInWithEmailAndPasswordFailure({
    this.message = 'Ha ocurrido un error desconocido.',
  });

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          message: 'El correo electrónico no es válido o está mal formateado.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          message:
              'Este usuario ha sido deshabilitado. Por favor, contacte a soporte.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          message: 'Usuario no encontrado. Por favor, cree una nueva cuenta.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          message: 'Contraseña incorrecta. Por favor, intente nuevamente.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure({
    this.message = 'Ha ocurrido un error desconocido.',
  });

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
            message: 'Esta cuenta ya existe con diferentes credenciales.');
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          message: 'La credencial recibida está mal formada o ha expirado.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          message: 'Operación no permitida.  Por favor, contacte a soporte.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          message:
              'Este usuario ha sido deshabilitado. Por favor, contacte a soporte.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          message: 'Usuario no encontrado. Por favor, cree una nueva cuenta.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          message: 'Contraseña incorrecta. Por favor, intente nuevamente.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          message: 'El código de verificación recibido es inválido.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          message: 'El ID de verificación recibido no es válido.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
}

class LogOutFailure implements Exception {}
