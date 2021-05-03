import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/network/youtube.dart';
import 'package:meta/meta.dart';

part 'business_content_event.dart';
part 'business_content_state.dart';

class BusinessContentBloc extends Bloc<BusinessContentEvent, BusinessContentState> {
  BusinessContentBloc(YoutubeRepository youtubeRepository)
      : assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository,
        super(null);

  YoutubeRepository _youtubeRepository;


  @override
  Stream<BusinessContentState> mapEventToState(BusinessContentEvent event) async* {
    if(event is GetBusinessPlaylistEvent) {
      yield LoadingToGetBusinessContent();

      List<PlaylistItem> listOfBusinessPlaylist = [];
      final response = await _youtubeRepository.getYoutubeChannelPlaylist();
      final playlists = response.items;
       for(var i = 0; i < playlists.length; i++){
         if(i == 0 || i == 1) {
           listOfBusinessPlaylist.insert(i, playlists[i]);
         }
       }

       yield GetBusinessContentStateDone(listOfBusinessPlaylist);

    }
  }
}
