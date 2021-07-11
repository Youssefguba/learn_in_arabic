import 'package:authentication_repository/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:uuid/uuid.dart';
import '../helpers/firestore_collection_names.dart';

abstract class UserRepositoryBase {
  void dispose();
}

/// [FailedToAddUser] is executed when Firestore Failed to Add User.
class FailedToAddUser implements Exception {}

/// [UserRepository] responsible for handling User Actions in Firestore.
class UserRepository extends UserRepositoryBase {
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(Path.users);

  Map _addressMap = Map();
  List _addressList = [];

  @override
  void dispose() {}

  /// Add User Data via [UserModel] To Firestore Database
  Future<void> addUserToFirestore(UserModel userModel, {socialUid}) async {
    String _userId = Uuid().v4();

    bool isExist = await isUserExisted(socialUid);
    if (isExist) {
      return null;
    } else {
      return _usersCollection.doc(socialUid ??= _userId).set({
        'userId': socialUid ?? _userId,
        'email': userModel.userEmail ?? null,
        'username': userModel.username ?? '',
        'picture': userModel.photoURL ?? null,
        'loggedInVia': userModel.loggedInVia ?? '',
        'phoneNumber': userModel.phoneNumber ?? null,
        'createdDate': DateTime.now(),
        'isBlocked': userModel.isBlocked ?? false,
        'tokenId': null,
        'favourites': [],
      });
    }
  }

  Future<bool> isUserExisted(userId) async {
    try {
      QuerySnapshot querySnapshot = await _usersCollection.get();
      String uid = querySnapshot.docs.map((e) => e.id).toString();
      bool isExisted = uid.contains(userId);
      return isExisted;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserFromFirestore(userId) async {
    final fetchUserData = await _usersCollection.doc(userId).get();
    return UserModel.fromFirestore(fetchUserData);
  }

  /// Block User from Using App.
  Future<void> blockUser(userId) async {
    return _usersCollection.doc(userId).update({'isBlocked': true});
  }

  /// unBlock User.
  Future<void> unBlockUser(userId) async {
    return _usersCollection.doc(userId).update({'isBlocked': false});
  }

  /// Update User Data
  Future<void> updateUserData(UserModel userModel, userId) {
    return _usersCollection.doc(userId).update({
      'email': userModel.userEmail,
      'username': userModel.username,
      'picture': userModel.photoURL ?? null,
      'phoneNumber': userModel.phoneNumber ?? null,
    });
  }

  /// Add New Address to User's Address List.
  Future<bool> addAddressToUserData({userId, AddressModel address}) async {
    try {
      _addressList.add({
        'addressName': address.addressName,
        'governate': address.governate,
        'area': address.area,
        'block': address.block,
        'street': address.street,
        'building': address.building,
        'paciNumber': address.paciNumber,
        'lat': address.lat,
        'long': address.long,
      });

      _addressMap.putIfAbsent('address', () => _addressList);
      _usersCollection.doc(userId).set({
        'addresses': _addressMap['address'],
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Get List Of Users' Addresses.
  Future<List<AddressModel>> fetchListOfUserAddresses(userId) async {
    List<AddressModel> userAddressesList = [];
    try {
      // get data from  .
      DocumentSnapshot _userData = await _usersCollection.doc(userId).get();

      // mapping data
      userAddressesList = List<AddressModel>.from(_userData
          .get(Path.addresses)
          .map((data) => AddressModel.fromMap(data)));

      return userAddressesList;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
