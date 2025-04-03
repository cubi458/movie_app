import 'package:flutter/material.dart';
import 'package:movie_app/presentation/app_localizations.dart';

extension StringExtensions on String{
  String intelliTrim(){
    return this.length > 15 ? '${this.substring(0, 15)}...' : this;
  }
  String t(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return localizations?.translate(this) ?? this;
  }

}