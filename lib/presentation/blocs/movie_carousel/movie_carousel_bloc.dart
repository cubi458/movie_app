import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
// import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc; // ✅ Thêm tham số này

  MovieCarouselBloc({
    required this.getTrending,
    required this.movieBackdropBloc, // ✅ Bắt buộc truyền vào
  }) : super(MovieCarouselInitial()) {
    on<CarouselLoadEvent>(_onCarouselLoadEvent);
  }

  Future<void> _onCarouselLoadEvent(
      CarouselLoadEvent event, Emitter<MovieCarouselState> emit) async {
    emit(MovieCarouselLoading());

    final moviesEither = await getTrending(NoParams());

    moviesEither.fold(
          (l) => emit(MovieCarouselError()),
          (movies) {
        emit(MovieCarouselLoaded(
          movies: movies,
          defaultIndex: event.defaultIndex,
        ));

        // ✅ Dùng movieBackdropBloc đã truyền vào constructor
        movieBackdropBloc.add(
          MovieBackdropChangedEvent(movies[event.defaultIndex]),
        );
      },
    );
  }
}
