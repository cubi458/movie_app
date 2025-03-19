import 'package:flutter/material.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListViewBuilder({
    Key? key, // ✅ Hỗ trợ null safety
    required this.movies, // ✅ Thay @required bằng required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h.toDouble()), // ✅ Ép kiểu num -> double
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 14.w.toDouble(), // ✅ Ép kiểu num -> double
          );
        },
        itemBuilder: (context, index) {
          final MovieEntity movie = movies[index];
          return MovieTabCardWidget(
            movieId: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
          );
        },
      ),
    );
  }
}
