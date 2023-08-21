part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool showPassword;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String errorMessage;

  const RegisterState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.showPassword = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.errorMessage = '',
  });

  RegisterState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? showPassword,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    String? errorMessage,
  }) =>
      RegisterState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        showPassword: showPassword ?? this.showPassword,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        isPosting,
        isFormPosted,
        isValid,
        showPassword,
        email,
        password,
        confirmPassword,
        errorMessage,
      ];
}
