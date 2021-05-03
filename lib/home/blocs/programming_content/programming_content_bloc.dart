import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/network/youtube.dart';
import 'package:meta/meta.dart';

part 'programming_content_event.dart';
part 'programming_content_state.dart';

class ProgrammingContentBloc
    extends Bloc<ProgrammingContentEvent, ProgrammingContentState> {
  ProgrammingContentBloc(YoutubeRepository youtubeRepository)
      : assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository,
        super(null);

  YoutubeRepository _youtubeRepository;


  @override
  Stream<ProgrammingContentState> mapEventToState(ProgrammingContentEvent event) async* {
    if (event is GetProgrammingPlaylistEvent) {
      yield LoadingToGetProgrammingContent();

      List<Item> listOfProgrammingPlaylist = [];
      final response = await _youtubeRepository.getYoutubeData();
      final playlists = response.items;
      for (var i = 0; i < playlists.length; i++) {
        if (i == 2 || i == 3 || i == 4 || i == 5)
          listOfProgrammingPlaylist.add(playlists[i]);
      }
      yield GetProgrammingContentStateDone(listOfProgrammingPlaylist);
    }
  }
}
