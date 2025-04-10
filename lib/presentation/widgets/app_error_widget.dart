import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:wiredash/wiredash.dart';

import 'button.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final VoidCallback onPressed; // ✅ Sửa Function -> VoidCallback

  const AppErrorWidget({
    Key? key, // ✅ Hỗ trợ null safety
    required this.errorType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w.toDouble()), // ✅ Ép kiểu num -> double
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong.t(context)
                : TranslationConstants.checkNetwork.t(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ButtonBar(
            children: [
              Button(
                onPressed: onPressed,
                text: TranslationConstants.retry,
              ),
              Button(
                onPressed: () => Wiredash.of(context).show(),
                text: TranslationConstants.feedback,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
