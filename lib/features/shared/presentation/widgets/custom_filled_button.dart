import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData? icon;
  final Color? buttonColor;
  final Color? textColor;
  final bool isPosting;
  final bool activateButton;
  final bool setTextTheme;

  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.buttonColor,
    this.textColor = Colors.white70,
    this.isPosting = false,
    this.activateButton = true,
    this.setTextTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;
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
          : icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      icon,
                      color: textColor,
                    ),
                    Text(
                      text,
                      style: setTextTheme
                          ? textStyle?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                            )
                          : TextStyle(
                              color: textColor,
                            ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: setTextTheme
                      ? textStyle?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                        )
                      : TextStyle(
                          color: textColor,
                        ),
                ),
    );
  }
}
