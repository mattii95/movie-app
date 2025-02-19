import 'package:isar/isar.dart';
import 'package:movie_app/domain/datasources/local_storage_datasource.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> database;

  IsarDatasource() {
    database = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await database;
    final Movie? isFavMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await database;
    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      // Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await database;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
}
