import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/auth/auth.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final colors = Theme.of(context).colorScheme;
    final textThemes = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => RegisterCubit(
        authRepository: context.read<AuthRepository>(),
      ),
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return KeyboardDismissOnTap(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: ScaffoldBackground(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 80.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (!context.canPop()) return;
                            context.pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 40.0,
                            color: colors.onSurface,
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('create_account'),
                          style: textThemes.titleLarge,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      height: context.select(
                        (RegisterCubit registerCubit) {
                          final showPassword = registerCubit.state.showPassword;

                          return isKeyboardVisible
                              ? size.height > 720
                                  ? showPassword
                                      ? size.height - 270.0 + keyboardHeight
                                      : size.height - 170.0 + keyboardHeight
                                  : showPassword
                                      ? size.height -
                                          100.0 +
                                          keyboardHeight * 0.75
                                      : size.height + keyboardHeight * 0.75
                              : size.height - 170.0;
                        },
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colors.onBackground.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100.0),
                        ),
                      ),
                      child: const _RegisterForm(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textThemes = Theme.of(context).textTheme;

    return BlocListener<RegisterCubit, RegisterState>(
      bloc: BlocProvider.of<RegisterCubit>(context),
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          SharedUtils.showSnackbar(
              context, state.errorMessage, colors.background, colors.onSurface);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Text(
                AppLocalizations.of(context).translate('new_account'),
                style:
                    textThemes.titleLarge?.copyWith(color: colors.background),
              ),
              const SizedBox(
                height: 60.0,
              ),
              _EmailTextField(),
              const SizedBox(
                height: 30.0,
              ),
              _PasswordTextField(),
              const SizedBox(
                height: 30.0,
              ),
              _ConfirmPasswordTextField(),
              _SignUpButton(),
              const SizedBox(
                height: 15.0,
              ),
              _HaveAccount(),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: BlocProvider.of<RegisterCubit>(context),
      builder: (context, state) => SizedBox(
        width: double.infinity,
        height: 60.0,
        child: CustomFilledButton(
          text: 'create',
          textColor: colors.onSurface,
          isPosting: state.isPosting,
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.read<RegisterCubit>().signUpFormSubmitted();
          },
        ),
      ),
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: BlocProvider.of<RegisterCubit>(context),
      builder: (context, state) => Visibility(
        visible: !state.showPassword,
        maintainState: true,
        maintainSize: false,
        maintainInteractivity: false,
        maintainAnimation: false,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'confirm_password',
              obscureText: true,
              onChanged: context.read<RegisterCubit>().onConfirmPassword,
              errorMessage: state.isFormPosted
                  ? state.confirmPassword.errorMessage
                  : null,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: BlocProvider.of<RegisterCubit>(context),
      builder: (context, state) => CustomTextFormField(
        label: 'password',
        obscureText: !state.showPassword,
        onChanged: context.read<RegisterCubit>().onPasswordChanged,
        errorMessage: state.isFormPosted ? state.password.errorMessage : null,
        changeShowPassword: context.read<RegisterCubit>().toggleShowPassword,
        showSuffixIcon: true,
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: BlocProvider.of<RegisterCubit>(context),
      builder: (context, state) => CustomTextFormField(
        label: 'email',
        keyboardType: TextInputType.emailAddress,
        onChanged: context.read<RegisterCubit>().onEmailChanged,
        errorMessage: state.isFormPosted ? state.email.errorMessage : null,
      ),
    );
  }
}

class _HaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).translate('have_account'),
          style: TextStyle(
            color: colors.background,
          ),
        ),
        TextButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (context.canPop()) {
              return context.pop();
            }
            context.go('/login');
          },
          child: Text(
            AppLocalizations.of(context).translate('enter_here'),
            style: TextStyle(
              color: colors.inversePrimary,
            ),
          ),
        ),
      ],
    );
  }
}
