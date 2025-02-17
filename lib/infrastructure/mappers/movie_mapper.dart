import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:movie_app/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: (movieDb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
            : 'https://rscomputacion.com/wp-content/themes/ryse/assets/images/no-image/No-Image-Found-400x264.png',
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: (movieDb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
            : 'https://rscomputacion.com/wp-content/themes/ryse/assets/images/no-image/No-Image-Found-400x264.png',
        releaseDate: movieDb.releaseDate != null ? movieDb.releaseDate! : DateTime.now(),
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: (movie.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
            : 'https://rscomputacion.com/wp-content/themes/ryse/assets/images/no-image/No-Image-Found-400x264.png',
        genreIds: movie.genres.map((e) => e.name).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: (movie.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://rscomputacion.com/wp-content/themes/ryse/assets/images/no-image/No-Image-Found-400x264.png',
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );
}
