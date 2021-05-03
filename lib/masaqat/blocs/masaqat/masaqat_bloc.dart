import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/network/network.dart';
import 'package:meta/meta.dart';

part 'masaqat_event.dart';
part 'masaqat_state.dart';

class MasaqatBloc extends Bloc<MasaqatEvent, MasaqatState> {
  MasaqatBloc(YoutubeRepository youtubeRepository)
      : assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository,
        super(null);

  YoutubeRepository _youtubeRepository;

  @override
  Stream<MasaqatState> mapEventToState(MasaqatEvent event) async* {
    if (event is GetListOfMasaqatEvent) {
      yield LoadingToGetMasaqatContent();
      List<PlaylistItem> listOfPlaylist = [];

      final response = await _youtubeRepository.getYoutubeChannelPlaylist();
      final playlists = response.items;
      for (var i = 0; i < playlists.length; i++) {
        listOfPlaylist.add(playlists[i]);
      }

      yield GetListOfMasaqatStateDone(listOfPlaylist);

    }
  }
}
