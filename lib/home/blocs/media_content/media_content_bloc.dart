import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/network/youtube.dart';
import 'package:meta/meta.dart';

part 'media_content_event.dart';
part 'media_content_state.dart';

class MediaContentBloc extends Bloc<MediaContentEvent, MediaContentState> {
  MediaContentBloc(YoutubeRepository youtubeRepository)
      : assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository,
        super(null);

  YoutubeRepository _youtubeRepository;


  @override
  Stream<MediaContentState> mapEventToState(MediaContentEvent event) async* {
    if(event is GetMediaPlaylistEvent) {
      yield LoadingToGetMediaContent();
      List<PlaylistItem> listOfMediaPlaylist = [];
      final response = await _youtubeRepository.getYoutubeChannelPlaylist();
      final playlists = response.items;
       for(var i = 0; i < playlists.length; i++){
         if (i == 6 || i == 7) {
           listOfMediaPlaylist.add(playlists[i]);
         }
       }

       yield GetMediaContentStateDone(listOfMediaPlaylist);

    }
  }
}
