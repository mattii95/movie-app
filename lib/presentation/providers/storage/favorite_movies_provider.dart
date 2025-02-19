import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/local_storage_repository.dart';
import 'package:movie_app/presentation/providers/storage/local_storage_provider.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
  {
    1234: Movie,
    5445: Movie,
    5557: Movie,
  }
 */

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  bool isLoading = false;
  int limit = 15;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
        offset: page * 10, limit: limit);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    final bool isMovieInFavorites =
        await localStorageRepository.isMovieFavorite(movie.id);
    await localStorageRepository.toggleFavorite(movie);

    // Si la película estaba en favoritos, se elimina del estado
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      // verificar si está cargando películas para que en ese momento se añdada la película y no antes
      if (isLoading && state.length >= limit) {
        state = {...state, movie.id: movie};
      }

      // verficar si  las películas en favoritos son menor al tamaño límite, en ese caso se agrega la película
      if (state.length < limit) state = {...state, movie.id: movie};

      //verifica si el tamaño es mayor a límite de pantalla, pero también se tiene en cuenta en caso de que no esté cargando películas
      if (state.length > limit && !isLoading) {
        state = {...state, movie.id: movie};
      }
    }
  }
}
