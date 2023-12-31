import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/auth/auth.dart';
import 'package:rick_and_morty_app/features/settings/settings.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final colors = Theme.of(context).colorScheme;

    return KeyboardVisibilityBuilder(
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
                  SizedBox(
                    height: 90.0,
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) => Image.asset(
                        'assets/images/app_bar_background_${state.language}.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    height: isKeyboardVisible
                        ? size.height > 805
                            ? size.height - 220.0 + keyboardHeight
                            : size.height + keyboardHeight * 0.65
                        : size.height - 220.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colors.onBackground.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                      ),
                    ),
                    child: BlocProvider(
                      create: (_) => LoginCubit(
                        authRepository: context.read<AuthRepository>(),
                      ),
                      child: const _LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return BlocListener<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
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
                AppLocalizations.of(context).translate('login'),
                style:
                    textStyles.titleLarge?.copyWith(color: colors.background),
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
              _LoginButton(),
              const SizedBox(
                height: 15.0,
              ),
              _GoogleLoginButton(),
              const SizedBox(
                height: 15.0,
              ),
              _CreateAccount(),
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

class _CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).translate('dont_have_account'),
          style: TextStyle(
            color: colors.background,
          ),
        ),
        TextButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.push('/register');
          },
          child: Text(
            AppLocalizations.of(context).translate('create_one'),
            style: TextStyle(
              color: colors.inversePrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      builder: (context, state) => SizedBox(
        width: double.infinity,
        height: 60.0,
        child: CustomFilledButton(
            text: 'enter',
            textColor: colors.onSurface,
            isPosting: state.isPosting,
            onPressed: state.isLoadingGoogle
                ? null
                : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<LoginCubit>().loginWithCredentials();
                  }),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      builder: (context, state) => CustomTextFormField(
        label: "password",
        onChanged: context.read<LoginCubit>().onPasswordChanged,
        onFieldSubmitted: (_) =>
            context.read<LoginCubit>().loginWithCredentials(),
        errorMessage: state.isFormPosted ? state.password.errorMessage : null,
        obscureText: !state.showPassword,
        changeShowPassword: context.read<LoginCubit>().toggleShowPassword,
        showSuffixIcon: true,
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      builder: (context, state) => CustomTextFormField(
        label: "email",
        keyboardType: TextInputType.emailAddress,
        onChanged: context.read<LoginCubit>().onEmailChanged,
        errorMessage: state.isFormPosted ? state.email.errorMessage : null,
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      builder: (context, state) => SizedBox(
        width: double.infinity,
        height: 60.0,
        child: CustomFilledButton(
            text: 'signin_google',
            textColor: colors.onSurface,
            icon: FontAwesomeIcons.google,
            isPosting: state.isLoadingGoogle,
            onPressed: state.isPosting
                ? null
                : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<LoginCubit>().loginWithGoogle();
                  }),
      ),
    );
  }
}
