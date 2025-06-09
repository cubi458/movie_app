import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

// Lớp SaveMovie thực thi UseCase để lưu một bộ phim vào repository
class SaveMovie extends UseCase<void, MovieEntity> {
  // Khai báo MovieRepository để sử dụng trong phương thức lưu phim
  final MovieRepository movieRepository;

  // Constructor để khởi tạo MovieRepository
  SaveMovie(this.movieRepository);

  // Phương thức call thực hiện lưu bộ phim thông qua repository
  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    // Gọi phương thức saveMovie từ repository và trả về kết quả
    return await movieRepository.saveMovie(params);
  }
}
