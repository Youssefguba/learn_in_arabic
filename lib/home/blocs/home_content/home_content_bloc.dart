import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/shared/model/youtube_model.dart';
import 'package:learn_in_arabic/shared/model/youtube_video.dart';
import 'package:learn_in_arabic/shared/network/youtube.dart';
import 'package:meta/meta.dart';

part 'home_content_event.dart';
part 'home_content_state.dart';

class HomeContentBloc
    extends Bloc<HomeContentEvent, HomeContentState> {
  HomeContentBloc(YoutubeRepository youtubeRepository)
      : assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository,
        super(null);

  YoutubeRepository _youtubeRepository;
  YoutubeVideo youtubeRes;
  List<VideoItem> listOfProgrammingPlaylist = [];


  @override
  Stream<HomeContentState> mapEventToState(HomeContentEvent event) async* {
    if (event is GetHomePlaylistEvent) {

      if(event.nextPageToken == null) {
        yield LoadingToGetHomeContent();
        listOfProgrammingPlaylist.clear();
      }
      youtubeRes = await _youtubeRepository.getChannelVideos(event.nextPageToken);
      final playlists = youtubeRes.items;
      for (var i = 0; i < playlists.length; i++) {
          listOfProgrammingPlaylist.add(playlists[i]);
      }
      yield GetHomeContentStateDone(listOfProgrammingPlaylist);
    }
  }

  scrollListener(ScrollController controller) {
    if (controller.position.maxScrollExtent == controller.offset) {
      add(GetHomePlaylistEvent(youtubeRes.nextPageToken));
    }
  }
}
