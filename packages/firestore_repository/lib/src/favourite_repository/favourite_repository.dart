import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import '../helpers/firestore_collection_names.dart';

abstract class FavouriteRepositoryBase {
  void dispose();
}

/// [FavouriteRepository] responsible for handling User Actions in Firestore.
class FavouriteRepository extends FavouriteRepositoryBase {
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(Path.users);

  Map _favouriteMap = Map();
  List _favouriteList = [];

  @override
  void dispose() {}

  /// Add Barber to Favourite List
  Future<bool> addBarberToFavouriteList({userId, barberId}) async {
    try {

      // Check if the user has put the barber in favourite before or not.
      List<String> listOfFavouriteBarbers = await fetchListOfFavouriteBarbers(userId);
      if (listOfFavouriteBarbers == null) {
        _favouriteList.add({'barberId': barberId});
        _favouriteMap.putIfAbsent('favourites', () => _favouriteList);
        _usersCollection.doc(userId).set({
          'favourites': _favouriteMap['favourites'],
        }, SetOptions(merge: true));
      } else if (listOfFavouriteBarbers != null && listOfFavouriteBarbers.contains(barberId)){
        return null;
      } else {
        _favouriteList.add({'barberId': barberId});
        _favouriteMap.putIfAbsent('favourites', () => _favouriteList);
        _usersCollection.doc(userId).set({
          'favourites': _favouriteMap['favourites'],
        }, SetOptions(merge: true));
      }

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Remove Barber to Favourite List
  Future<bool> removeBarberToFavouriteList({userId, barberId}) async {
    try {
      /// fetch list of favourite barbers
      List<String> listOfFavouriteBarbers =
          await fetchListOfFavouriteBarbers(userId);

      /// Check if the user has put the barber in favourite before or not.
      if (listOfFavouriteBarbers.contains(barberId)) {
        // get Index of barber ID
        int indexOfBarber = listOfFavouriteBarbers.indexOf(barberId);
        // remove barber by index.
        _favouriteList.removeAt(indexOfBarber);
        _favouriteMap.putIfAbsent('favourites', () => _favouriteList);
        _usersCollection.doc(userId).set({
          'favourites': _favouriteMap['favourites'],
        }, SetOptions(merge: true));
      } else {
        return null;
      }
      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Get List Of Users' Favourite List
  Future<List<String>> fetchListOfFavouriteBarbers(userId) async {
    List<String> barbersId = [];
    try {
      DocumentSnapshot _userData = await _usersCollection.doc(userId).get();

      // mapping data
      barbersId = List<String>.from(_userData.get(Path.favourites).map((data) => data['barberId']));
      return barbersId;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
