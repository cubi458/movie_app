import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';

import '../data/repositories/movie_repository_imple.dart';
import '../domain/repositores/movie_repository.dart';

final getItInstance = GetIt.I;

Future init() async{
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  // ⚠️ ĐĂNG KÝ MovieRepository TRƯỚC khi gọi UseCase
  getItInstance
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(getItInstance<MovieRemoteDataSource>()));

  getItInstance
    .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));
  getItInstance
      .registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));
}