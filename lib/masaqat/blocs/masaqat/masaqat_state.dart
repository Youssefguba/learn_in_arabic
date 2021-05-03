part of 'masaqat_bloc.dart';

@immutable
abstract class MasaqatState {}

class MasaqatInitial extends MasaqatState {}

class GetListOfMasaqatStateDone extends MasaqatState {
  final List<PlaylistItem> listOfPlaylist;
  final List<YoutubePlaylistVideoModel> listOfVideos;
  GetListOfMasaqatStateDone(this.listOfPlaylist, this.listOfVideos);
}

class LoadingToGetMasaqatContent extends MasaqatState {}

