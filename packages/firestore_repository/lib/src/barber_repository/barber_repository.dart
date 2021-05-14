import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../helpers/helpers.dart';
import '../models/models.dart';

abstract class BarberRepositoryBase {
  void dispose();
}

/// Return when Failed to Get Barbers List.
class FailedToGetBarbersList implements Exception {}

class BarberRepository extends BarberRepositoryBase {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference _barbersCollection =
      FirebaseFirestore.instance.collection(Path.barbers);

  // Init variables
  Map _serviceMap = Map();
  Map _galleryMap = Map();
  Map _availableDatesMap = Map();
  List _servicesList = [];
  List _galleryList = [];
  List _availableDatesList = [];

  @override
  void dispose() {}

  /// Add User Data via [BarberModel] To Firestore Database
  Future<void> addBarberToFirestore(BarberModel barberModel) async {
    String _userId = Uuid().v4();
    return _barbersCollection.doc(_userId).set({
      'barberId': _userId,
      'barberEmail': barberModel.email,
      'username': barberModel.name,
      'photoURL': barberModel.photoURL ?? null,
      'createdDate': DateTime.now(),
      'totalRating': barberModel.totalRating,
      'totalOfClients': barberModel.totalOfClients,
      'isFeatured': barberModel.isFeatured,
    });
  }

  /// Update Barber Data
  Future<void> updateBarberData(BarberModel barberModel, barberId) {
    return _barbersCollection.doc(barberId).update({
      'email': barberModel.email,
      'username': barberModel.name,
      'picture': barberModel.photoURL ?? null,
      'phoneNumber': barberModel.phoneNumber ?? null,
    });
  }

  /// Get List of Featured Barbers.
  Future<List<BarberModel>> fetchListOfFeaturedBarbers({
    @required bool isFeatured,
  }) async {
    List<BarberModel> barbersList;
    try {
      QuerySnapshot querySnapshot = await db
          .collection(Path.barbers)
          .where('isFeatured', isEqualTo: isFeatured)
          .get();
      barbersList = List<BarberModel>.from(
        querySnapshot.docs.map(
          (snapshot) => BarberModel.fromMap(snapshot.data()),
        ),
      );
      return barbersList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Add Service of Barber
  Future<bool> addBarberService(uid, BarberServices services) async {
    try {
      _servicesList.add({
        'serviceName': services.serviceName,
        'servicePrice': services.servicePrice,
        'serviceId': services.serviceId,
        'serviceAvgTime': services.serviceAvgTime,
      });
      _serviceMap.putIfAbsent('services', () => _servicesList);
      _barbersCollection
          .doc(uid)
          .set({'services': _serviceMap['services']}, SetOptions(merge: true));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Get List Of Barber's Service.
  Future<List<BarberServices>> fetchListOfBarberService({@required uid}) async {
    List<BarberServices> barberServices = [];
    try {
      // get data from firestore.
      DocumentSnapshot _barberData =
          await db.collection(Path.barbers).doc(uid).get();

      // mapping data
      barberServices = List<BarberServices>.from(_barberData
          .get(Path.services)
          .map((data) => BarberServices.fromMap(data)));
      return barberServices;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Get Barber Profile Details
  Future<BarberModel> fetchBarberInfo({@required uid}) async {
    try {
      // get data from firestore.
      DocumentSnapshot _barberData =
          await db.collection(Path.barbers).doc(uid).get();

      // mapping data
      return BarberModel.fromMap(_barberData.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Add Image To Barber Gallery
  Future<bool> addPhotoToBarberGallery({
    @required File file,
    @required String barberName,
    @required uid,
  }) async {
    try {
      String imageURL = await uploadImgToStorage(file, barberName);

      _galleryList.add({'photoURL': imageURL});
      _galleryMap.putIfAbsent('gallery', () => _galleryList);
      _barbersCollection
          .doc(uid)
          .set({'gallery': _galleryMap['gallery']}, SetOptions(merge: true));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Upload Image to Firestore Storage
  Future<String> uploadImgToStorage(File file, String barberName) async {
    try {
      FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      var uuid = Uuid().v4();
      Reference storageReference =
          storage.ref().child('barbers/gallery/$barberName/$uuid');
      await storageReference.putFile(file);
      return storageReference.getDownloadURL();
    } on FirebaseException catch (e) {
      print("Error of uploading files $e");
      return e.toString();
    }
  }

  /// Get List Of Barber's Service.
  Future<List<BarberGallery>> fetchListOfBarberGallery({@required uid}) async {
    List<BarberGallery> barberGallery = [];

    try {
      // get data from firestore.
      DocumentSnapshot _barberData =
          await db.collection(Path.barbers).doc(uid).get();

      // mapping data
      barberGallery = List<BarberGallery>.from(_barberData
          .get(Path.gallery)
          .map((data) => BarberGallery.fromMap(data)));
      return barberGallery;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Add List of Available Dates for Barber.
  Future<bool> addAvailableDates(uid, availableDate) async {
    try {
      _availableDatesList
          .add({'availableDate': availableDate, 'available': true});
      _availableDatesMap.putIfAbsent(
          'availableDate', () => _availableDatesList);
      _barbersCollection.doc(uid).set(
          {'AvailableDates': _availableDatesMap['availableDate']},
          SetOptions(merge: true));

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get List of Featured Barbers.
  Future<List<BarberModel>> fetchListOfFavouriteBarbers(
      {@required barberId}) async {
    List<BarberModel> barbersList;
    try {
      QuerySnapshot querySnapshot = await db
          .collection(Path.barbers)
          .where('barberId', isEqualTo: barberId)
          .get();

      barbersList = List<BarberModel>.from(
        querySnapshot.docs.map(
          (snapshot) => BarberModel.fromMap(snapshot.data()),
        ),
      );
      return barbersList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  

}
