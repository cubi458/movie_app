import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class ThemeText {
  const ThemeText._();

  // Khai báo TextTheme sử dụng GoogleFonts Poppins
  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  // Khai báo text style cho titleLarge
  static TextStyle get _whiteTitleLarge => _poppinsTextTheme.titleLarge!.copyWith(
    fontSize: Sizes.dimen_20.sp.toDouble(), // Ép kiểu num -> double
    color: Colors.white,
  );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.titleMedium!.copyWith(
    fontSize: Sizes.dimen_16.sp.toDouble(),
    color: Colors.white,
  );

  static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyMedium!.copyWith(
    color: Colors.white,
    fontSize: Sizes.dimen_14.sp.toDouble(),
    wordSpacing: 0.25,
    letterSpacing: 0.25,
    height: 1.5,
  );

  // Hàm lấy TextTheme tùy chỉnh
  static TextTheme getTextTheme() => TextTheme(
    titleLarge: _whiteTitleLarge, // Sử dụng titleLarge thay vì headline6
  );
}

// ✅ Sửa lỗi và chỉ giữ một extension duy nhất
extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => titleMedium!.copyWith( // 🔥 Thay subtitle1 -> titleMedium
    color: AppColor.royalBlue,
    fontWeight: FontWeight.w600,
  );
}


