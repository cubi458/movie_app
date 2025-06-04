import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/presentation/app_localizations.dart';

materialWrapperWithBlocs(
    Widget child,
    List<BlocProvider> blocProviders,
    NavigatorObserver observer,
    ) {
  return MultiBlocProvider(
    providers: blocProviders,
    child: MaterialApp(
      // Sử dụng 'vi' làm locale mặc định nếu cần thiết
      locale: Locale(Languages.languages[1].code), // Tiếng Việt (vi) mặc định
      supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: child,
      navigatorObservers: [observer],
    ),
  );
}
