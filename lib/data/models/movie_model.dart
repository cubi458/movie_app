import 'package:movie_app/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final bool video;
  final int voteCount;

  const MovieModel({
    required int id,
    required String title,
    required String originalTitle,
    required String overview,
    required String posterPath,
    required String backdropPath,
    required String mediaType,
    required bool adult,
    required String originalLanguage,
    required List<int> genreIds,
    required double popularity,
    required String releaseDate,
    required bool video,
    required double voteAverage,
    required int voteCount,
  }) : this.mediaType = mediaType,
        this.adult = adult,
        this.originalLanguage = originalLanguage,
        this.genreIds = genreIds,
        this.popularity = popularity,
        this.video = video,
        this.voteCount = voteCount,
        super(
        id: id,
        title: title,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
        overview: overview,
        posterPath: posterPath,
      );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      mediaType: json['media_type'] ?? '',
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      popularity: (json['popularity'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
