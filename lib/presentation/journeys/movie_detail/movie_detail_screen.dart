import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguments.dart';

import '../../blocs/bloc/movie_detail_bloc.dart';
import 'big_poster.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({
    Key? key,
    required this.movieDetailArguments, // dùng required với named parameter
  })  : assert(movieDetailArguments != null, 'argument must not be null'),
        super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc.add(
      MovieDetailLoadEvent(
        widget.movieDetailArguments.movieId,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _movieDetailBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    body: BlocProvider<MovieDetailBloc>.value(
      value: _movieDetailBloc,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state){
          if(state is MovieDetailLoaded){
            final movieDetail = state.movieDetailEntity;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              BigPoster(
                movie: movieDetail,
              )
            ],);
            return Container();
          }else if (state is MovieDetailError){
            return Container();
          }
          return SizedBox.shrink();
        }
      ),
    ));
  }
}
