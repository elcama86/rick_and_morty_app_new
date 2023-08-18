import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rick_and_morty_app/features/auth/auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authRepository,
  }) : super(const LoginState());

  final AuthRepository authRepository;

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> loginWithCredentials() async {
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
      await authRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        state.copyWith(
          isPosting: false,
        ),
      );
    } on LogInWithEmailAndPasswordFailure catch (e) {
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

  Future<void> loginWithGoogle() async {
    emit(
      state.copyWith(
        isLoadingGoogle: true,
        errorMessage: '',
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await authRepository.logInWithGoogle();
      emit(
        state.copyWith(
          isLoadingGoogle: false,
        ),
      );
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          isLoadingGoogle: false,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingGoogle: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(
      state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]),
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
