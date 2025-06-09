import 'package:hive/hive.dart';

import '../tables/movie_table.dart';

// Định nghĩa lớp trừu tượng MovieLocalDataSource
abstract class MovieLocalDataSource {
  // Lưu thông tin phim vào local database
  Future<void> saveMovie(MovieTable movieTable);

  // Lấy danh sách các phim từ local database
  Future<List<MovieTable>> getMovies();

  // Xóa phim khỏi local database theo ID
  Future<void> deleteMovie(int movieId);

  // Kiểm tra xem một phim có được đánh dấu yêu thích không
  Future<bool> checkIfMovieFavorite(int movieId);
}

// Lớp triển khai MovieLocalDataSource để làm việc với Hive
class MovieLocalDataSourceImpl extends MovieLocalDataSource {

  // Kiểm tra xem phim có được đánh dấu là yêu thích trong Hive hay không
  @override
  Future<bool> checkIfMovieFavorite(int movieId) async {
    // Mở hộp dữ liệu 'movieBox' trong Hive
    final movieBox = await Hive.openBox('movieBox');

    // Kiểm tra nếu phim tồn tại trong Hive theo ID
    return movieBox.containsKey(movieId);
  }

  // Xóa một bộ phim khỏi Hive theo ID
  @override
  Future<void> deleteMovie(int movieId) async {
    // Mở hộp dữ liệu 'movieBox' trong Hive
    final movieBox = await Hive.openBox('movieBox');

    // Xóa phim khỏi hộp dữ liệu theo ID
    await movieBox.delete(movieId);
  }

  // Lấy danh sách tất cả các phim từ Hive
  @override
  Future<List<MovieTable>> getMovies() async {
    // Mở hộp dữ liệu 'movieBox' trong Hive
    final movieBox = await Hive.openBox('movieBox');

    // Lấy tất cả các ID phim trong hộp dữ liệu
    final movieIds = movieBox.keys;

    // Tạo một danh sách để lưu các phim
    List<MovieTable> movies = [];

    // Lặp qua tất cả các ID phim và lấy dữ liệu phim từ Hive
    movieIds.forEach((movieId) {
      final movie = movieBox.get(movieId);
      if (movie != null) {
        movies.add(movieBox.get(movieId));  // Thêm phim vào danh sách
      }
    });

    // Trả về danh sách phim
    return movies;
  }

  // Lưu một bộ phim vào Hive
  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    // Mở hộp dữ liệu 'movieBox' trong Hive
    final movieBox = await Hive.openBox('movieBox');

    // Lưu phim vào hộp dữ liệu với ID là khóa
    await movieBox.put(movieTable.id, movieTable);
  }
}
