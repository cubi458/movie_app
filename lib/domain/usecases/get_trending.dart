import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class GetTrending extends UseCase<List<MovieEntity>, NoParams>{
  final MovieRepository repository;

  GetTrending(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async{
    return await repository.getTrending();
  }
}