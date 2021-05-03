part of 'programming_content_bloc.dart';

@immutable
abstract class ProgrammingContentState {}

class ProgrammingContentInitial extends ProgrammingContentState {}

class GetProgrammingContentStateDone extends ProgrammingContentState {
  final List<Item> listOfProgrammingPlaylist;
  GetProgrammingContentStateDone(this.listOfProgrammingPlaylist);
}

class LoadingToGetProgrammingContent extends ProgrammingContentState {}

