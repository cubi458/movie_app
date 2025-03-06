import 'package:flutter/material.dart';
import '../../common/extensions/size_extensions.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({
    super.key, // ✅ Dùng super.key thay vì Key key
    required this.height, // ✅ Dùng required thay vì @required
  })  : assert(height > 0, 'height should be greater than 0'); // ✅ Không cần kiểm tra null vì `required` đảm bảo height không null

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      color: Colors.white,
      height: height.h.toDouble(), // ✅ Đảm bảo giá trị là double
    );
  }
}
