import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                height: 100.0,
                child: Image.asset(
                  'assets/images/app_bar_background.png',
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              Container(
                height: size.height - 260.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.onBackground.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                  ),
                ),
                child: const _LoginForm(),
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
    final textStyles = Theme.of(context).textTheme;

    return BlocListener<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          SharedUtils.showSnackbar(context, state.errorMessage);
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
                style: textStyles.titleLarge?.copyWith(color: Colors.black),
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
        const Text(
          '¿No tienes cuenta?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {},
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
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      builder: (context, state) => SizedBox(
        width: double.infinity,
        height: 60.0,
        child: CustomFilledButton(
          text: 'Ingresar',
          buttonColor: Colors.black,
          isPosting: state.isPosting,
          onPressed: state.isLoadingGoogle
              ? null
              : context.read<LoginCubit>().loginWithCredentials,
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
      buildWhen: (previous, current) => previous.email != current.email,
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
    const radius = Radius.circular(10);

    return BlocBuilder<LoginCubit, LoginState>(
      bloc: BlocProvider.of<LoginCubit>(context),
      builder: (context, state) => SizedBox(
        width: double.infinity,
        height: 60.0,
        child: state.isLoadingGoogle
            ? CustomFilledButton(
                text: '',
                buttonColor: Colors.black,
                isPosting: state.isLoadingGoogle,
              )
            : ElevatedButton.icon(
                label: const Text(
                  'Iniciar sesión con Google',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: radius,
                      bottomRight: radius,
                      topLeft: radius,
                    ),
                  ),
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.black.withOpacity(0.5),
                ),
                icon: const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white70,
                ),
                onPressed: state.isPosting
                    ? null
                    : context.read<LoginCubit>().loginWithGoogle,
              ),
      ),
    );
  }
}
