import 'package:movie_app/domain/datasources/actors_datasource.dart';
import 'package:movie_app/domain/entities/actor.dart';
import 'package:movie_app/domain/repositories/actores_repository.dart';

class ActorRepositoryImpl extends ActoresRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
  
}
