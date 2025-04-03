import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/screenutil/screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/journeys/home/home_screen.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc _languageBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();

    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if(state is LanguageLoaded){
            print('🟢 current languageCode: ${state.locale.languageCode}');
            return WiredashApp(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Movie App',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.royalBlue,
                  primaryColor: AppColor.vulcan,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0),
                ),
                supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate, // ✅ thêm dòng này
                ],
                home: HomeScreen(),
              ),
              languageCode: state.locale.languageCode,

            );
          }
          return const SizedBox.shrink();
        }
      ),
    );
  }
}
