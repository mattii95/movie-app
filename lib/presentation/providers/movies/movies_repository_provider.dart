import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movie_app/infrastructure/repositories/movie_repository_impl.dart';

// Repositorio inmutable - solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
