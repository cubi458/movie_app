import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/entities/no_params.dart';
import '../../../domain/usecases/get_coming_soon.dart';
import '../../../domain/usecases/get_playing_now.dart';
import '../../../domain/usecases/get_popular.dart';

part 'movie_tabbed_event.dart';

part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedBloc({
    required this.getPopular,
    required this.getPlayingNow,
    required this.getComingSoon,
  }) : super(MovieTabbedInitial()) {
    on<MovieTabChangedEvent>(_onMovieTabChangedEvent);
  }

  Future<void> _onMovieTabChangedEvent(
      MovieTabChangedEvent event, Emitter<MovieTabbedState> emit) async {
    print("Received MovieTabChangedEvent with index: ${event.currentTabIndex}");
    Either<AppError, List<MovieEntity>> moviesEither = Right(
        []); // Khởi tạo với danh sách trống

    switch (event.currentTabIndex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getPlayingNow(NoParams());
        break;
      case 2:
        moviesEither = await getComingSoon(NoParams());
        break;
    }
    // emit(
    //   MovieTabLoadError(
    //     currentTabIndex: event.currentTabIndex,
    //     errorType: AppErrorType.network,
    //   ),
    // );


    emit(moviesEither.fold(
          (l) => MovieTabLoadError(
            currentTabIndex: event.currentTabIndex,
            errorType: l.appErrorType,
          ),
          (movies) => MovieTabChanged(
        currentTabIndex: event.currentTabIndex,
        movies: movies,
      ),
    ));
  }
}

