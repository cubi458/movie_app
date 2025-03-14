import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

class MovieDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
        builder: (context, state) {
      if (state is MovieBackdropChanged) {
        return Text(
          state.movie.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: Colors.black.withOpacity(0.7), // Bóng tối phía sau chữ
                offset: Offset(2, 2),
              ),
            ],
          ),
        );

      }
      return const SizedBox.shrink();
    });
  }
}
