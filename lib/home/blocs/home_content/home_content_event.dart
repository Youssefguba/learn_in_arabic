part of 'home_content_bloc.dart';

@immutable
abstract class HomeContentEvent {}

class GetHomePlaylistEvent extends HomeContentEvent {
  final nextPageToken;
  GetHomePlaylistEvent(this.nextPageToken);
}

