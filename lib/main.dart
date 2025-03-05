import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository_imple.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/repositores/movie_repository.dart';
import 'domain/entities/app_error.dart';
import 'domain/usecases/get_trending.dart';
import 'di/get_it.dart'as getIt;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo khởi tạo Flutter trước khi chạy async
  await getIt.init(); // Gọi hàm khởi tạo dependency injection
  GetTrending getTrending = getIt.getItInstance<GetTrending>();

  final Either<AppError, List<MovieEntity>> eitherResponse =
  await getTrending(NoParams());

  eitherResponse.fold(
        (l) {
      print('error');
      print(l);
    },
        (r) {
      print('list of movies');
      print(r);
    },
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
