part of 'business_content_bloc.dart';

@immutable
abstract class BusinessContentState {}

class BusinessContentInitial extends BusinessContentState {}

class GetBusinessContentStateDone extends BusinessContentState {
  final List<Item> listOfBusinessPlaylist;
  GetBusinessContentStateDone(this.listOfBusinessPlaylist);
}

class LoadingToGetBusinessContent extends BusinessContentState {}

