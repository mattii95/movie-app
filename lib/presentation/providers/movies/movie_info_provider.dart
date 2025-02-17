import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movie.dart';

import 'movies_repository_provider.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final fetchMovieById = ref.watch(movieRepositoryProvider).getMovieById;
      return MovieMapNotifier(getMovie: fetchMovieById);
    });

/* 

  {
    '912649': Movie(),
    '912650': Movie(),
    '912651': Movie(),
    '912652': Movie(),
  }

*/

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;


    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
