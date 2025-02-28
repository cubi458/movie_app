import 'package:movie_app/domain/entities/movie_entity.dart';
import '../../domain/repositores/movie_repository.dart';
import '../data_sources/movie_remote_data_source.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource; // ✅ Thêm biến thành viên

  MovieRepositoryImpl(this.remoteDataSource); // ✅ Khởi tạo đúng cách

  @override
  Future<List<MovieEntity>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return movies;
    } catch (e) {
      throw Exception("Failed to fetch trending movies: $e"); // ✅ Xử lý lỗi đúng cách
    }
  }
}
