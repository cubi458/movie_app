import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';

class ThemeText {
  const ThemeText._();

  // Khai báo TextTheme sử dụng GoogleFonts Poppins
  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  // Khai báo text style cho titleLarge
  static TextStyle get _whiteTitleLarge => _poppinsTextTheme.titleLarge!.copyWith(
    fontSize: Sizes.dimen_20.sp.toDouble(), // Ép kiểu num -> double
    color: Colors.white,
  );

  // Hàm lấy TextTheme tùy chỉnh
  static getTextTheme() => TextTheme(
    titleLarge: _whiteTitleLarge, // Sử dụng titleLarge thay vì headline6
  );
}
