import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/entities/app_error.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/movie_local_data_source.dart';
import '../data_sources/movie_remote_data_source.dart';
import '../models/cast_crew_result_data_model.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/video_model.dart';
import '../tables/movie_table.dart';

// Lớp MovieRepositoryImpl triển khai MovieRepository, xử lý logic kết nối với cả nguồn dữ liệu từ xa (remote) và dữ liệu cục bộ (local)
class MovieRepositoryImpl extends MovieRepository {
  // Khai báo các đối tượng nguồn dữ liệu từ xa và cục bộ
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  // Constructor của MovieRepositoryImpl
  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  // Lấy danh sách phim đang hot (trending) từ nguồn dữ liệu từ xa
  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return Right(movies);  // Trả về danh sách phim thành công
    } on SocketException {
      return Left(AppError(AppErrorType.network));  // Lỗi kết nối mạng
    } on Exception {
      return Left(AppError(AppErrorType.api));  // Lỗi từ API
    }
  }

  // Lấy danh sách phim sắp ra mắt (coming soon) từ nguồn dữ liệu từ xa
  @override
  Future<Either<AppError, List<MovieModel>>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Lấy danh sách phim đang chiếu (playing now) từ nguồn dữ liệu từ xa
  @override
  Future<Either<AppError, List<MovieModel>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Lấy danh sách phim phổ biến (popular) từ nguồn dữ liệu từ xa
  @override
  Future<Either<AppError, List<MovieModel>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Lấy chi tiết thông tin của một bộ phim từ nguồn dữ liệu từ xa
  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Lấy thông tin về diễn viên và đoàn làm phim của một bộ phim
  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try {
      final castCrew = await remoteDataSource.getCastCrew(id);
      return Right(castCrew);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Lấy danh sách video (ví dụ: trailer) của một bộ phim
  @override
  Future<Either<AppError, List<VideoModel>>> getVideos(int id) async {
    try {
      final videos = await remoteDataSource.getVideos(id);
      return Right(videos);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Tìm kiếm phim theo từ khóa tìm kiếm từ nguồn dữ liệu từ xa
  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(
      String searchTerm) async {
    try {
      final movies = await remoteDataSource.getSearchedMovies(searchTerm);
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // Kiểm tra xem một bộ phim có được đánh dấu yêu thích trong cơ sở dữ liệu cục bộ hay không
  @override
  Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId) async {
    try {
      final response = await localDataSource.checkIfMovieFavorite(movieId);
      return Right(response);  // Trả về kết quả kiểm tra
    } on Exception {
      return Left(AppError(AppErrorType.database));  // Lỗi cơ sở dữ liệu
    }
  }

  // Xóa bộ phim yêu thích khỏi cơ sở dữ liệu cục bộ
  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  // Lấy danh sách các bộ phim yêu thích từ cơ sở dữ liệu cục bộ
  @override
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies() async {
    try {
      final response = await localDataSource.getMovies();
      return Right(response);  // Trả về danh sách phim yêu thích
    } on Exception {
      return Left(AppError(AppErrorType.database));  // Lỗi cơ sở dữ liệu
    }
  }

  // Lưu bộ phim vào cơ sở dữ liệu cục bộ
  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
    try {
      // Chuyển đổi từ MovieEntity sang MovieTable để lưu vào cơ sở dữ liệu
      final table = MovieTable.fromMovieEntity(movieEntity);
      print(table);  // In thông tin phim để kiểm tra
      final response = await localDataSource.saveMovie(table);
      return Right(response);  // Trả về kết quả lưu phim thành công
    } on Exception {
      return Left(AppError(AppErrorType.database));  // Lỗi cơ sở dữ liệu
    }
  }
}
