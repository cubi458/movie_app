import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/entities/movie_params.dart';
import '../../../domain/entities/no_params.dart';
import '../../../domain/usecases/check_if_movie_favorite.dart';
import '../../../domain/usecases/delete_favorite_movie.dart';
import '../../../domain/usecases/get_favorite_movies.dart';
import '../../../domain/usecases/save_movie.dart';

part 'favorite_state.dart';

// Lớp FavoriteCubit quản lý trạng thái yêu thích phim, kế thừa từ Cubit
class FavoriteCubit extends Cubit<FavoriteState> {
  // Các usecase cần thiết cho việc lưu, xóa, lấy và kiểm tra phim yêu thích
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;

  // Constructor để khởi tạo các usecase
  FavoriteCubit({
    required this.saveMovie,
    required this.getFavoriteMovies,
    required this.deleteFavoriteMovie,
    required this.checkIfFavoriteMovie,
  }) : super(FavoriteInitial());  // Khởi tạo trạng thái ban đầu

  // Phương thức để thay đổi trạng thái yêu thích của một bộ phim
  void toggleFavoriteMovie(MovieEntity movieEntity, bool isFavorite) async {
    // Nếu phim đã là yêu thích, xóa khỏi yêu thích, nếu chưa thì thêm vào yêu thích
    if (isFavorite) {
      await deleteFavoriteMovie(MovieParams(movieEntity.id));  // Xóa phim khỏi yêu thích
    } else {
      await saveMovie(movieEntity);  // Lưu phim vào danh sách yêu thích
    }

    // Kiểm tra lại xem phim có được đánh dấu yêu thích hay không sau khi thay đổi
    final response = await checkIfFavoriteMovie(MovieParams(movieEntity.id));
    emit(response.fold(
          (l) => FavoriteMoviesError(),  // Nếu có lỗi, phát ra trạng thái lỗi
          (r) => IsFavoriteMovie(r),  // Nếu thành công, phát ra trạng thái phim yêu thích
    ));
  }

  // Phương thức tải danh sách các phim yêu thích
  void loadFavoriteMovie() async {
    final Either<AppError, List<MovieEntity>> response =
    await getFavoriteMovies(NoParams());  // Lấy danh sách phim yêu thích

    emit(response.fold(
          (l) => FavoriteMoviesError(),  // Nếu có lỗi, phát ra trạng thái lỗi
          (r) => FavoriteMoviesLoaded(r),  // Nếu thành công, phát ra trạng thái phim yêu thích
    ));
  }

  // Phương thức xóa một bộ phim khỏi danh sách yêu thích
  void deleteMovie(int movieId) async {
    await deleteFavoriteMovie(MovieParams(movieId));  // Xóa phim theo ID
    loadFavoriteMovie();  // Tải lại danh sách phim yêu thích
  }

  // Phương thức kiểm tra một bộ phim có phải là yêu thích hay không
  void checkIfMovieFavorite(int movieId) async {
    final response = await checkIfFavoriteMovie(MovieParams(movieId));  // Kiểm tra phim theo ID
    emit(response.fold(
          (l) => FavoriteMoviesError(),  // Nếu có lỗi, phát ra trạng thái lỗi
          (r) => IsFavoriteMovie(r),  // Nếu thành công, phát ra trạng thái phim yêu thích
    ));
  }
}
