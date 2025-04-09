import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteTitleLarge => _poppinsTextTheme.titleLarge!.copyWith(
    fontSize: Sizes.dimen_20.sp.toDouble(),
    color: Colors.white,
  );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.titleMedium!.copyWith(
    fontSize: Sizes.dimen_16.sp.toDouble(),
    color: Colors.white,
  );
  static TextStyle get _whiteButton => _poppinsTextTheme.labelLarge!.copyWith(
    fontSize: Sizes.dimen_14.sp.toDouble(),
    color: Colors.white,
  );
  static TextStyle get _whiteHeadline => _poppinsTextTheme.headlineSmall!.copyWith(
    fontSize: Sizes.dimen_24.sp.toDouble(),
    color: Colors.white,
  );

  static TextStyle get whiteBodyText => _poppinsTextTheme.bodyMedium!.copyWith(
    color: Colors.white,
    fontSize: Sizes.dimen_14.sp.toDouble(),
    wordSpacing: 0.25,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextTheme getTextTheme() => TextTheme(
    titleLarge: _whiteTitleLarge,
    headlineSmall: _whiteHeadline,
    bodyMedium: whiteBodyText,
    titleMedium: whiteSubtitle1,
    labelLarge: _whiteButton,
  );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => titleMedium!.copyWith(
    color: AppColor.royalBlue,
    fontWeight: FontWeight.w600,
  );
}
