import 'package:flutter/material.dart';
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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
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
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          Text(
            'Inicio de sesión',
            style: textStyles.titleLarge?.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 80.0,
          ),
          const CustomTextFormField(
            label: "Correo Electrónico",
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            label: "Contraseña",
            changeShowPassword: () {},
            showSuffixIcon: true,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
