part of 'wish_list_bloc.dart';

@immutable
abstract class WishListEvent {}

class AddItemToWishListEvent extends WishListEvent {
  final VideoItem videoItem;
  AddItemToWishListEvent(this.videoItem);
}

class RemoveItemFromWishListEvent extends WishListEvent {
  final index;
  RemoveItemFromWishListEvent(this.index);

}

class GetWishListItems extends WishListEvent {}