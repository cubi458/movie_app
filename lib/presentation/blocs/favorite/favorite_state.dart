part of 'favorite_cubit.dart';

// Lớp FavoriteState là lớp cơ sở cho tất cả các trạng thái liên quan đến yêu thích phim
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

// Trạng thái khởi tạo, khi không có dữ liệu yêu thích nào được tải
class FavoriteInitial extends FavoriteState {}

// Trạng thái khi danh sách phim yêu thích đã được tải thành công
class FavoriteMoviesLoaded extends FavoriteState {
  final List<MovieEntity> movies;  // Danh sách các bộ phim yêu thích

  // Constructor nhận danh sách phim yêu thích
  FavoriteMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];  // Trả về danh sách phim yêu thích để so sánh trong Equatable
}

// Trạng thái khi có lỗi xảy ra trong quá trình tải danh sách phim yêu thích
class FavoriteMoviesError extends FavoriteState {}

// Trạng thái khi kiểm tra một bộ phim có phải là yêu thích hay không
class IsFavoriteMovie extends FavoriteState {
  final bool isMovieFavorite;  // Biến boolean cho biết phim có phải yêu thích hay không

  // Constructor nhận giá trị boolean
  IsFavoriteMovie(this.isMovieFavorite);

  @override
  List<Object> get props => [isMovieFavorite];  // Trả về giá trị boolean để so sánh trong Equatable
}
