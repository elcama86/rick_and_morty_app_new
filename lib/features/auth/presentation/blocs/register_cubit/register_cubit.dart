import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rick_and_morty_app/features/auth/domain/domain.dart';
import 'package:rick_and_morty_app/features/auth/infrastructure/infrastructure.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.authRepository,
  }) : super(const RegisterState());

  final AuthRepository authRepository;

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: !state.showPassword
            ? Formz.validate([email, state.password, state.confirmPassword])
            : Formz.validate([email, state.password]),
      ),
    );
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    final confirmPassword = ConfirmPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: !state.showPassword
            ? Formz.validate([password, confirmPassword, state.email])
            : Formz.validate([password, state.email]),
      ),
    );
  }

  void onConfirmPassword(String value) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: value,
    );

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([confirmPassword, state.email, state.password]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    _touchEveryField();
    if (!state.isValid) return;

    emit(
      state.copyWith(
        isPosting: true,
        errorMessage: '',
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          isPosting: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isPosting: false,
        ),
      );
    }
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: state.confirmPassword.value);

    emit(
      state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        isValid: !state.showPassword
            ? Formz.validate([email, password, confirmPassword])
            : Formz.validate([email, password]),
      ),
    );
  }

  void toggleShowPassword() {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
      ),
    );
  }
}
