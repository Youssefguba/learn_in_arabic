part of 'wish_list_bloc.dart';

@immutable
abstract class WishListState {}

class WishListInitial extends WishListState {}

class ItemAddedToWishListSuccessfully extends WishListState {}

class ItemRemovedToWishListSuccessfully extends WishListState {}

class GetWishListItemStateDone extends WishListState {
  final List wishlist;
  GetWishListItemStateDone(this.wishlist);
}

class FailedToAddItemToWishList extends WishListState {}

class FailedToRemoveItemToWishList extends WishListState {}

class FailedToGetWishListItems extends WishListState {}

