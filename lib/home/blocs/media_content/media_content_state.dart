part of 'media_content_bloc.dart';

@immutable
abstract class MediaContentState {}

class MediaContentInitial extends MediaContentState {}

class GetMediaContentStateDone extends MediaContentState {
  final List<Item> listOfMediaPlaylist;
  GetMediaContentStateDone(this.listOfMediaPlaylist);
}

class LoadingToGetMediaContent extends MediaContentState {}
