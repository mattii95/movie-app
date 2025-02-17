// Repositorio inmutable - solo lectura
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:movie_app/infrastructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource: ActorMoviedbDatasource());
});
