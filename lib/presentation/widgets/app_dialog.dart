import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';


class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget image;

  const AppDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog( // ✅ Dùng `builder` thay vì `child`
      backgroundColor: AppColor.vulcan,
      elevation: Sizes.dimen_32.toDouble(),
      insetPadding: EdgeInsets.all(Sizes.dimen_32.w.toDouble()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_8.w.toDouble()),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              title.t(context),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h.toDouble()),
            child: Text(
              description.t(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          )
        ],
      )

    );
  }
}