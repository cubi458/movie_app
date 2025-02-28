import 'movie_model.dart';

class MoviesResultModel {
  final List<MovieModel> movies;

  MoviesResultModel({required this.movies});

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) {
    return MoviesResultModel(
      movies: (json['results'] as List<dynamic>?)
          ?.map((item) => MovieModel.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': movies.map((v) => v.toJson()).toList(),
    };
  }
}
