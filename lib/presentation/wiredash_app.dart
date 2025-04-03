import 'package:flutter/material.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final Widget child;
  final String languageCode;

  const WiredashApp({
    Key? key,
    required this.child,
    required this.languageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('🈶 Wiredash languageCode: $languageCode');
    return Wiredash(
      projectId: 'movie-app-xoou57n',
      secret: 'L-sCKMVu-VOZLdgoBNFjOI7GRuhQFtTE',
      child: child,
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(
          languageCode: languageCode,
        )
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
      ),
    );
  }
}
