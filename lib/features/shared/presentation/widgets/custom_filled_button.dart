import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final bool isPosting;
  final bool activateButton;

  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonColor,
    this.textColor = Colors.white70,
    this.isPosting = false,
    this.activateButton = true,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        disabledBackgroundColor: buttonColor?.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
          ),
        ),
      ),
      onPressed: isPosting
          ? null
          : activateButton
              ? onPressed
              : null,
      child: isPosting
          ? CircularProgressIndicator(
              strokeWidth: 2,
              color: buttonColor,
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
              ),
            ),
    );
  }
}