import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_params.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

// Lớp DeleteFavoriteMovie thực thi UseCase để xóa một bộ phim yêu thích
class DeleteFavoriteMovie extends UseCase<void, MovieParams> {
  // Khai báo MovieRepository để sử dụng trong phương thức xóa phim yêu thích
  final MovieRepository movieRepository;

  // Constructor để khởi tạo MovieRepository
  DeleteFavoriteMovie(this.movieRepository);

  // Phương thức call thực hiện xóa bộ phim yêu thích thông qua repository
  @override
  Future<Either<AppError, void>> call(MovieParams movieParams) async {
    // Gọi phương thức deleteFavoriteMovie từ repository và trả về kết quả
    return await movieRepository.deleteFavoriteMovie(movieParams.id);
  }
}
