import 'package:movie_app/domain/entities/actor.dart';

abstract class ActoresRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
