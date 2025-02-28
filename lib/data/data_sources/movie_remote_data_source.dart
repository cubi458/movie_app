import 'package:http/http.dart';
import 'package:movie_app/data/core/api_constant.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movies_result_model.dart';
import 'dart:convert'; // Thêm để sử dụng json.decode()
import 'package:http/http.dart' as http;

import '../core/api_client.dart'; // Thêm để sử dụng Client


abstract class MovieRemoteDataSource{
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
}
class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
      return movies;

  }
  Future<List<MovieModel>> getPopular() async{
    final response = await _client.get('movie/popular');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async{
    final response = await _client.get('movie/upcoming');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async{
    final response = await _client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }
}
