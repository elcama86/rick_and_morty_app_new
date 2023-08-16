import 'package:formz/formz.dart';

// Define input validation errors
enum ConfirmPasswordError { match }

// Extend FormzInput and provide the input type and error type.
class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {
  final String password;

  // Call super.pure to represent an unmodified form input.
  const ConfirmPassword.pure({this.password = ''}) : super.pure("");

  // Call super.dirty to represent a modified form input.
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmPasswordError.match) {
      return 'La contraseña no coincide';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ConfirmPasswordError? validator(String value) {
    if (value != password) return ConfirmPasswordError.match;

    return null;
  }
}
