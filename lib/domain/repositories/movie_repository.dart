import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import '../entities/app_error.dart';
import '../entities/movie_detail_entity.dart';

abstract class MovieRepository{
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id);
}