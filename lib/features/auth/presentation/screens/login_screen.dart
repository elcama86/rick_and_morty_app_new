import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/auth/domain/domain.dart';
import 'package:rick_and_morty_app/features/auth/presentation/blocs/blocs.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: ScaffoldBackground(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(
                height: 80.0,
              ),
              SizedBox(
                height: 90.0,
                child: Image.asset(
                  'assets/images/app_bar_background.png',
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: size.height - 220.0,
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
          SharedUtils.showSnackbar(context, state.errorMessage, colors.background, colors.onSurface);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Inicio de sesión',
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
          '¿No tienes cuenta?',
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
            'Crea una aquí',
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
          text: 'Ingresar',
          textColor: colors.onSurface,
          isPosting: state.isPosting,
          onPressed: state.isLoadingGoogle
              ? null
              : () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<LoginCubit>().loginWithCredentials();
                },
        ),
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
        label: "Contraseña",
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
        label: "Correo Electrónico",
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
          text: 'Iniciar sesión con Google',
          textColor: colors.onSurface,
          icon: FontAwesomeIcons.google,
          isPosting: state.isLoadingGoogle,
          onPressed: state.isPosting
              ? null
              : () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<LoginCubit>().loginWithGoogle();
                },
        ),
      ),
    );
  }
}
