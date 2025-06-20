import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import '../domain/usecases/get_preferred_theme.dart';
import '../domain/usecases/update_theme.dart';
import '../presentation/blocs/theme/theme_cubit.dart';

import '../data/core/api_client.dart';
import '../data/data_sources/authentication_local_data_source.dart';
import '../data/data_sources/authentication_remote_data_source.dart';
import '../data/data_sources/language_local_data_source.dart';
import '../data/data_sources/movie_local_data_source.dart';
import '../data/data_sources/movie_remote_data_source.dart';
import '../data/repositories/app_repository_impl.dart';
import '../data/repositories/authentication_repository_impl.dart';
import '../data/repositories/movie_repository_impl.dart';
import '../domain/repositories/app_repository.dart';
import '../domain/repositories/authentication_repository.dart';
import '../domain/repositories/movie_repository.dart';
import '../domain/usecases/check_if_movie_favorite.dart';
import '../domain/usecases/delete_favorite_movie.dart';
import '../domain/usecases/get_cast.dart';
import '../domain/usecases/get_coming_soon.dart';
import '../domain/usecases/get_favorite_movies.dart';
import '../domain/usecases/get_movie_detail.dart';
import '../domain/usecases/get_playing_now.dart';
import '../domain/usecases/get_popular.dart';
import '../domain/usecases/get_preferred_language.dart';
import '../domain/usecases/get_trending.dart';
import '../domain/usecases/get_videos.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/logout_user.dart';
import '../domain/usecases/save_movie.dart';
import '../domain/usecases/search_movies.dart';
import '../domain/usecases/update_language.dart';
import '../presentation/blocs/cast/cast_cubit.dart';
import '../presentation/blocs/favorite/favorite_cubit.dart';
import '../presentation/blocs/language/language_cubit.dart';
import '../presentation/blocs/loading/loading_cubit.dart';
import '../presentation/blocs/login/login_cubit.dart';
import '../presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import '../presentation/blocs/movie_carousel/movie_carousel_cubit.dart';
import '../presentation/blocs/movie_detail/movie_detail_cubit.dart';
import '../presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import '../presentation/blocs/search_movie/search_movie_cubit.dart';
import '../presentation/blocs/videos/videos_cubit.dart';

// Đối tượng getItInstance để truy cập các đối tượng đã đăng ký
final getItInstance = GetIt.I;

Future init() async {
  // Đăng ký các dịch vụ HTTP Client cho các yêu cầu mạng
  getItInstance.registerLazySingleton<Client>(() => Client());

  // Đăng ký ApiClient với sự phụ thuộc vào Client
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // Đăng ký các data source liên quan đến phim từ xa và cục bộ
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());

  // Đăng ký các data source liên quan đến ngôn ngữ và xác thực người dùng
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(() => AuthenticationLocalDataSourceImpl());

  // Đăng ký các UseCase cho việc lấy và xử lý dữ liệu về phim
  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  // Đăng ký các UseCase cho việc lưu và xóa phim yêu thích
  getItInstance.registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(() => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(() => DeleteFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(() => CheckIfFavoriteMovie(getItInstance()));

  // Đăng ký các UseCase liên quan đến ngôn ngữ và chủ đề
  getItInstance.registerLazySingleton<UpdateLanguage>(() => UpdateLanguage(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferredLanguage>(() => GetPreferredLanguage(getItInstance()));
  getItInstance.registerLazySingleton<UpdateTheme>(() => UpdateTheme(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferredTheme>(() => GetPreferredTheme(getItInstance()));

  // Đăng ký các UseCase cho việc đăng nhập và đăng xuất người dùng
  getItInstance.registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance.registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  // Đăng ký các repository cho phim, xác thực và ứng dụng
  getItInstance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  // Đăng ký các Bloc sử dụng các usecase và services đã đăng ký
  getItInstance.registerFactory(() => MovieBackdropCubit());
  getItInstance.registerFactory(() => MovieCarouselCubit(
    loadingCubit: getItInstance(),
    getTrending: getItInstance(),
    movieBackdropCubit: getItInstance(),
  ));

  getItInstance.registerFactory(() => MovieTabbedCubit(
    getPopular: getItInstance(),
    getComingSoon: getItInstance(),
    getPlayingNow: getItInstance(),
  ));

  getItInstance.registerFactory(() => MovieDetailCubit(
    loadingCubit: getItInstance(),
    getMovieDetail: getItInstance(),
    castBloc: getItInstance(),
    videosCubit: getItInstance(),
    favoriteCubit: getItInstance(),
  ));

  getItInstance.registerFactory(() => CastCubit(getCast: getItInstance()));
  getItInstance.registerFactory(() => VideosCubit(getVideos: getItInstance()));
  getItInstance.registerFactory(() => SearchMovieCubit(
    loadingCubit: getItInstance(),
    searchMovies: getItInstance(),
  ));

  // Đăng ký LanguageCubit như là một singleton
  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  // Đăng ký FavoriteCubit, LoginCubit và LoadingCubit như là các factory
  getItInstance.registerFactory(() => FavoriteCubit(
    saveMovie: getItInstance(),
    checkIfFavoriteMovie: getItInstance(),
    deleteFavoriteMovie: getItInstance(),
    getFavoriteMovies: getItInstance(),
  ));

  getItInstance.registerFactory(() => LoginCubit(
    loginUser: getItInstance(),
    logoutUser: getItInstance(),
    loadingCubit: getItInstance(),
  ));

  // Đăng ký các singleton cho LoadingCubit và ThemeCubit
  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    getPreferredTheme: getItInstance(),
    updateTheme: getItInstance(),
  ));
}
