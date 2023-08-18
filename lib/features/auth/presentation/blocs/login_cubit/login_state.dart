part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool showPassword;
  final Email email;
  final Password password;
  final String errorMessage;
  final bool isLoadingGoogle;

  const LoginState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.showPassword = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.errorMessage = '',
    this.isLoadingGoogle = false,
  });

  LoginState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? showPassword,
    Email? email,
    Password? password,
    String? errorMessage,
    bool? isLoadingGoogle,
  }) =>
      LoginState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        showPassword: showPassword ?? this.showPassword,
        email: email ?? this.email,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoadingGoogle: isLoadingGoogle ?? this.isLoadingGoogle,
      );

  @override
  List<Object> get props => [
        isPosting,
        isFormPosted,
        isValid,
        showPassword,
        email,
        password,
        errorMessage,
        isLoadingGoogle,
      ];
}
