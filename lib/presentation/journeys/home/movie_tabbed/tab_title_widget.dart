import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class TabTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap; // ✅ Đổi Function -> VoidCallback (chuẩn Flutter)
  final bool isSelected;

  const TabTitleWidget({
    Key? key, // ✅ Sửa Key? thay vì Key (do null safety)
    required this.title, // ✅ Dùng required thay vì @required
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ Đã đổi Function -> VoidCallback
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColor.royalBlue : Colors.transparent,
              width: Sizes.dimen_1.h.toDouble(), // ✅ Ép kiểu num -> double
            ),
          ),
        ),
        child: Text(
         title.t(context),
          style: isSelected
              ? Theme.of(context).textTheme.royalBlueSubtitle1
              : Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white), // ✅ Đổi màu chữ chưa chọn thành trắng
        ),
      ),
    );
  }
}
