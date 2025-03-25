import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/widgets/logo.dart';
import 'navigation_expanded_list_item.dart';
import 'navigation_list_item.dart';

class NavigationDraw extends StatelessWidget {
  const NavigationDraw();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.dimen_300.w.toDouble(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h.toDouble(),
                bottom: Sizes.dimen_18.h.toDouble(),
                left: Sizes.dimen_8.w.toDouble(),
                right: Sizes.dimen_8.w.toDouble(),
              ),
              child: Logo(
                height: Sizes.dimen_40.h.toDouble(),
              ),
            ),
            NavigationListItem(
              title: AppLocalizations.of(context)
                  ?.translate(TranslationConstants.favoriteMovies)
                  ?? 'Favorite Movies',
              onPressed: () {},
            ),
            NavigationExpandedListItem(
              title: AppLocalizations.of(context)
                  ?.translate(TranslationConstants.language)
                  ?? 'Language',
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: () {},
            ),
            NavigationListItem(
              title: AppLocalizations.of(context)
                  ?.translate(TranslationConstants.feedback)
                  ?? 'Feedback',
              onPressed: () {},
            ),
            NavigationListItem(
              title: AppLocalizations.of(context)
                  ?.translate(TranslationConstants.about)
                  ?? 'About',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}