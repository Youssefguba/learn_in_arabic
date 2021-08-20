import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/shared/model/youtube_video.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial());

  @override
  Stream<WishListState> mapEventToState(WishListEvent event) async* {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (event is AddItemToWishListEvent) {
      try {
        List wishlist;
        var listOfWishItems = _prefs.get(PreferenceKeys.wishList);
        if (listOfWishItems != null) {
          wishlist =
              json.decode(_prefs.get(PreferenceKeys.wishList)).toSet().toList();
        } else {
          wishlist = [];
        }
        wishlist.add(event.videoItem);
        _prefs.setString(
            PreferenceKeys.wishList, json.encode(wishlist.toSet().toList()));
      } catch (e) {
        print('Error in AddItemToWishListEvent $e');
        yield FailedToAddItemToWishList();
      }
    }

    if (event is RemoveItemFromWishListEvent) {
      final wishlist = json.decode(_prefs.get(PreferenceKeys.wishList));
      wishlist.remove(event.index);
      _prefs.setString(PreferenceKeys.wishList, json.encode(wishlist));
    }

    if (event is GetWishListItems) {
      try {
        List wishlist;
        var listOfWishItems = _prefs.get(PreferenceKeys.wishList);
        if (listOfWishItems != null) {
          wishlist = json.decode(_prefs.get(PreferenceKeys.wishList)).toSet().toList();
        } else {
          wishlist = [];
        }
        final videoItemList = List<VideoItem>.from(
          wishlist.map(
            (serviceModel) {
              return VideoItem.fromJson(serviceModel);
            },
          ),
        );

        if (wishlist == null || wishlist.isEmpty) {
          yield FailedToGetWishListItems();
        } else {
          yield GetWishListItemStateDone(videoItemList.toSet().toList());
        }
      } catch (e) {
        print('this is an error in GetWishListItems $e');
        yield FailedToGetWishListItems();
      }
    }
  }
}
