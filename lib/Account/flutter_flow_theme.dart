import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return FlutterFlowTheme();
  }

  Color get primaryColor => const Color(0xFF0367A6);
  Color get secondaryColor => const Color(0xFF787DEA);
  Color get backgroundColor => const Color(0xFFE6EFF9);
  Color get secondaryBackground => const Color(0xFFF1F4F8);
  Color get primaryBackground => const Color(0xFFFFFFFF);
  Color get secondaryText => const Color(0xFF757575);
  Color get primaryText => const Color(0xFF000000);
  Color get alternate => const Color(0xFF787DEA);
  Color get error => const Color(0xFFEF5350);

  TextStyle get displaySmall => TextStyle(
    fontFamily: 'Yangjin',
    color: primaryText,
    fontSize: 24,
  );

  TextStyle get labelLarge => TextStyle(
    fontFamily: 'Yangjin',
    color: primaryText,
    fontSize: 16,
  );

  TextStyle get bodyLarge => TextStyle(
    fontFamily: 'Yangjin',
    color: primaryText,
    fontSize: 14,
  );

  TextStyle get titleSmall => TextStyle(
    fontFamily: 'Yangjin',
    color: Colors.white,
    fontSize: 14,
  );

  TextStyle get labelMedium => TextStyle(
    fontFamily: 'Yangjin',
    color: primaryText,
    fontSize: 12,
  );

  TextStyle get bodyMedium => TextStyle(
    fontFamily: 'Yangjin',
    color: primaryText,
    fontSize: 14,
  );
}
