part of 'programming_content_bloc.dart';

@immutable
abstract class ProgrammingContentState {}

class ProgrammingContentInitial extends ProgrammingContentState {}

class GetProgrammingContentStateDone extends ProgrammingContentState {
  final List<VideoItem> listOfVideos;
  GetProgrammingContentStateDone(this.listOfVideos);
}

class LoadingToGetProgrammingContent extends ProgrammingContentState {}

