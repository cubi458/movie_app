import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailInitial()) {
    on<MovieDetailLoadEvent>((event, emit) async {
      final Either<AppError, MovieDetailEntity> eitherResponse =
      await getMovieDetail(
        MovieParams(event.movieId),
      );

      eitherResponse.fold(
            (failure) => emit(MovieDetailError()),
            (movieDetail) => emit(MovieDetailLoaded(movieDetail)),
      );
    });
  }
}
