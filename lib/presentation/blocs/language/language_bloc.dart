import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/domain/entities/language_entity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(LanguageLoaded(Locale(Languages.languages[0].code))) {
    on<ToggleLanguageEvent>((event, emit) {
      emit(LanguageLoaded(Locale(event.language.code)));
    });
  }
}

