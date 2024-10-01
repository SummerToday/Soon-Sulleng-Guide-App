import 'package:flutter/material.dart';

class FFButtonOptions {
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry iconPadding;
  final Color color;
  final TextStyle textStyle;
  final double elevation;
  final BorderSide borderSide;
  final BorderRadiusGeometry borderRadius;
  final Color hoverColor;

  FFButtonOptions({
    required this.width,
    required this.height,
    required this.padding,
    required this.iconPadding,
    required this.color,
    required this.textStyle,
    required this.elevation,
    required this.borderSide,
    required this.borderRadius,
    this.hoverColor = Colors.transparent,
  });
}

class FFButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final FFButtonOptions options;
  final Widget? icon;

  const FFButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.options,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ?? Container(),
      label: Text(text, style: options.textStyle),
      style: ElevatedButton.styleFrom(
        backgroundColor: options.color, // primary 대신 backgroundColor 사용
        foregroundColor: options.hoverColor, // onPrimary 대신 foregroundColor 사용
        minimumSize: Size(options.width, options.height),
        padding: options.padding,
        shape: RoundedRectangleBorder(
          borderRadius: options.borderRadius,
          side: options.borderSide,
        ),
        elevation: options.elevation,
      ),
    );
  }
}
