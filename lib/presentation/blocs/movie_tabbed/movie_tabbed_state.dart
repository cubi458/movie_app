part of 'movie_tabbed_bloc.dart';

abstract class MovieTabbedState extends Equatable {
  final int? currentTabIndex;  // Làm cho currentTabIndex có thể là null

  const MovieTabbedState({this.currentTabIndex});

  @override
  List<Object?> get props => [currentTabIndex];
}

class MovieTabbedInitial extends MovieTabbedState {}

class MovieTabChanged extends MovieTabbedState {
  final List<MovieEntity>? movies;  // Làm cho movies có thể là null

  const MovieTabChanged({int? currentTabIndex, this.movies})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object?> get props => [currentTabIndex, movies];
}

class MovieTabLoadError extends MovieTabbedState {

  final AppErrorType errorType;
  const MovieTabLoadError({
    int? currentTabIndex,
    required this.errorType,
  })
      : super(currentTabIndex: currentTabIndex);
}
