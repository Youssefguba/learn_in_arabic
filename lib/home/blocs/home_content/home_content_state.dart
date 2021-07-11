part of 'home_content_bloc.dart';

@immutable
abstract class HomeContentState {}

class ProgrammingContentInitial extends HomeContentState {}

class GetHomeContentStateDone extends HomeContentState {
  final List<VideoItem> listOfVideos;
  GetHomeContentStateDone(this.listOfVideos);
}

class LoadingToGetHomeContent extends HomeContentState {}

