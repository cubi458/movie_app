import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final double? voteAverage; // Sửa kiểu dữ liệu ở đây
  final String? backdropPath;
  final String? posterPath;

  MovieDetailEntity({
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.backdropPath,
    this.posterPath,
  });

  @override
  List<Object?> get props => [id, title, overview, releaseDate, voteAverage, backdropPath, posterPath];
}
