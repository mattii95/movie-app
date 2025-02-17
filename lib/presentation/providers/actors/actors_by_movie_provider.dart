import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/actor.dart';
import 'package:movie_app/presentation/providers/actors/actors_repository_provider.dart';


final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
      final fetchActorsByMovieId = ref.watch(actorsRepositoryProvider);
      return ActorsByMovieNotifier(getActors: fetchActorsByMovieId.getActorsByMovie);
    });

/* 

  {
    '912649': List<Actor>,
    '912650': List<Actor>,s
    '912651': List<Actor>,
    '912652': List<Actor>,
  }

*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;


    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
