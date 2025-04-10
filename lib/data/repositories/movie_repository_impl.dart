import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import '../../domain/repositores/movie_repository.dart';
import '../data_sources/movie_remote_data_source.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource; // ✅ Thêm biến thành viên

  MovieRepositoryImpl(this.remoteDataSource); // ✅ Khởi tạo đúng cách

  @override
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    } on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async{
    try {
      final movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async{
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async{
    try {
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }
}
