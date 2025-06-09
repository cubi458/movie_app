import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_params.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

// Lớp CheckIfFavoriteMovie thực thi UseCase để kiểm tra xem một bộ phim có phải là yêu thích hay không
class CheckIfFavoriteMovie extends UseCase<bool, MovieParams> {
  // Khai báo MovieRepository để sử dụng trong phương thức kiểm tra phim yêu thích
  final MovieRepository movieRepository;

  // Constructor để khởi tạo MovieRepository
  CheckIfFavoriteMovie(this.movieRepository);

  // Phương thức call thực hiện kiểm tra xem bộ phim có yêu thích hay không thông qua repository
  @override
  Future<Either<AppError, bool>> call(MovieParams movieParams) async {
    // Gọi phương thức checkIfMovieFavorite từ repository và trả về kết quả
    return await movieRepository.checkIfMovieFavorite(movieParams.id);
  }
}
