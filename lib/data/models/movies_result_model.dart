import 'movie_model.dart';

class MovieResultModel {
  final List<MovieModel> results;

  MovieResultModel({required this.results});

  factory MovieResultModel.fromJson(Map<String, dynamic> json) {
    return MovieResultModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((item) => MovieModel.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((v) => v.toJson()).toList(),
    };
  }
}
