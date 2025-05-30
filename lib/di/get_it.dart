import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/domain/entities/language_entity.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/bloc/movie_detail_bloc.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';

import '../data/repositories/movie_repository_impl.dart';
import '../domain/repositories/movie_repository.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() =>
      ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(getItInstance()),
  );

  // ✅ Đăng ký MovieRepository CHỈ MỘT LẦN
  getItInstance.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(getItInstance<MovieRemoteDataSource>()),
  );

  getItInstance.registerLazySingleton<GetTrending>(
        () => GetTrending(getItInstance()),
  );
  getItInstance.registerLazySingleton<GetPopular>(
        () => GetPopular(getItInstance()),
  );
  getItInstance.registerLazySingleton<GetPlayingNow>(
        () => GetPlayingNow(getItInstance()),
  );
  getItInstance.registerLazySingleton<GetComingSoon>(
        () => GetComingSoon(getItInstance()),
  );

  // ✅ Chỉ đăng ký MovieBackdropBloc một lần
  getItInstance.registerFactory<MovieBackdropBloc>(
        () => MovieBackdropBloc(),
  );

  // ✅ Truyền MovieBackdropBloc vào MovieCarouselBloc
  getItInstance.registerFactory<MovieCarouselBloc>(
        () =>
        MovieCarouselBloc(
          getTrending: getItInstance(),
          movieBackdropBloc: getItInstance(), // 🔥 Truyền MovieBackdropBloc vào
        ),
  );
  getItInstance.registerFactory(() =>
      MovieTabbedBloc(
        getPopular: (getItInstance()),
        getPlayingNow: (getItInstance()),
        getComingSoon: (getItInstance()),
      ));
  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());

  getItInstance.registerLazySingleton<GetMovieDetail>(
          () => GetMovieDetail(getItInstance()));


  getItInstance.registerFactory(
        () => MovieDetailBloc(
        getMovieDetail: getItInstance(),
    ),
  );
}