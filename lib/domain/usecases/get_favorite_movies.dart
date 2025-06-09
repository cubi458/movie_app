import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_entity.dart';
import '../entities/no_params.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

// Lớp GetFavoriteMovies thực thi UseCase để lấy danh sách các bộ phim yêu thích
class GetFavoriteMovies extends UseCase<List<MovieEntity>, NoParams> {
  // Khai báo MovieRepository để sử dụng trong phương thức lấy phim yêu thích
  final MovieRepository movieRepository;

  // Constructor để khởi tạo MovieRepository
  GetFavoriteMovies(this.movieRepository);

  // Phương thức call thực hiện lấy danh sách các bộ phim yêu thích từ repository
  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async {
    // Gọi phương thức getFavoriteMovies từ repository và trả về kết quả
    return await movieRepository.getFavoriteMovies();
  }
}
