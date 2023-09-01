import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/config.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? changeShowPassword;
  final Function(String)? onFieldSubmitted;
  final bool showSuffixIcon;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.changeShowPassword,
    this.onFieldSubmitted,
    this.showSuffixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    const borderRadius = Radius.circular(15);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
          bottomRight: borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: TextFormField(
        scrollPadding: EdgeInsets.only(
          bottom: keyboardHeight,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black54,
        ),
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: colors.outline,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          isDense: true,
          label: label != null
              ? Text(
                  AppLocalizations.of(context).translate(label!),
                )
              : null,
          hintText: hint,
          errorText: errorMessage != null
              ? AppLocalizations.of(context).translate(errorMessage!)
              : null,
          focusColor: colors.primary,
          suffixIcon: showSuffixIcon
              ? IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: changeShowPassword,
                )
              : null,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
