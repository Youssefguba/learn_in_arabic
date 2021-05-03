part of 'masaqat_bloc.dart';

@immutable
abstract class MasaqatState {}

class MasaqatInitial extends MasaqatState {}

class GetListOfMasaqatStateDone extends MasaqatState {
  final List<PlaylistItem> listOfPlaylist;
  GetListOfMasaqatStateDone(this.listOfPlaylist);
}

class LoadingToGetMasaqatContent extends MasaqatState {}

