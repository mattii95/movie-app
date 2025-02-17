import 'package:dio/dio.dart';
import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/domain/datasources/actors_datasource.dart';
import 'package:movie_app/domain/entities/actor.dart';
import 'package:movie_app/infrastructure/mappers/actor_mapper.dart';
import 'package:movie_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-AR'
      }));

  List<Actor> _jsonToActor(Map<String, dynamic> json) {
    final creaditResponse = CreditsResponse.fromJson(json);
    final List<Actor> actors =
        creaditResponse.cast.map((e) => ActorMapper.castToEntity(e)).toList();
    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final respose = await dio.get('/movie/$movieId/credits');
    return _jsonToActor(respose.data);
  }
}
