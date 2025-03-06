import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
// import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;

  MovieCarouselBloc({required this.getTrending}) : super(MovieCarouselInitial()) {
    // Đăng ký handler cho sự kiện CarouselLoadEvent
    on<CarouselLoadEvent>(_onCarouselLoadEvent);
  }

  Future<void> _onCarouselLoadEvent(
      CarouselLoadEvent event, Emitter<MovieCarouselState> emit) async {
    emit(MovieCarouselLoading()); // Trạng thái loading trước khi lấy dữ liệu

    final moviesEither = await getTrending(NoParams());

    moviesEither.fold(
          (l) => emit(MovieCarouselError()), // Nếu lỗi, emit trạng thái lỗi
          (movies) => emit(MovieCarouselLoaded(
        movies: movies,
        defaultIndex: event.defaultIndex,
      )),
    );
  }
}
