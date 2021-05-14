import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/models/available_date_model.dart';
import 'package:meta/meta.dart';

import '../helpers/helpers.dart';
import '../../firestore_repository.dart';

abstract class BaseBookingRepository {
  void dispose();
}

class BookingRepository extends BaseBookingRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(Path.users);


  @override
  void dispose() {}

  /// Add Services of Booking in Bookings List.
  Future<bool> addServiceToBookingList({
    @required String userId,
    @required List<ServiceModel> service,
    @required bookingId,
  }) async {
    List _servicesList = [];

    try {
      for (var i = 0; i < service.length; i++) {
        _servicesList.add(service[i].toJson());
      }

      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'services': _servicesList,
        'status': 'pending',
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Get Services of Booking in Bookings List.
  Future<ServiceModel> fetchServiceOfBookingList(
      String userId, String bookingId) async {
    try {
      DocumentSnapshot _data = await _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .get();
      ServiceModel _serviceData = ServiceModel.fromMap(_data.data());
      return _serviceData;
    } catch (e) {
      print('This is error of adding $e');
      return null;
    }
  }

  /// Get List Of Barber's Available Dates.
  Future<List<AvailableDateModel>> fetchListOfAvailableDates(barberId) async {
    List<AvailableDateModel> availableDatesList = [];
    try {
      // get data from firestore.
      DocumentSnapshot _barberData =
          await db.collection(Path.barbers).doc(barberId).get();

      // mapping data
      availableDatesList = List<AvailableDateModel>.from(_barberData
          .get(Path.availableDates)
          .map((data) => AvailableDateModel.fromMap(data)));

      return availableDatesList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Add Time To Booking List.
  Future<bool> addTimeToBooking({userId, fromTime, toTime, bookingId}) async {
    try {
      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'fromTime': fromTime,
        'toTime': toTime,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Add Date To Booking List.
  Future<bool> addDateToBooking({
    @required userId,
    @required bookingDate,
    @required barberId,
    @required bookingId,
  }) async {
    try {
      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'bookingDate': bookingDate,
        'barberId': barberId,
        'bookingId': bookingId,
        'userId': userId,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Add Address To Booking List.
  Future<bool> addAddressToBooking({
    @required userId,
    @required AddressModel address,
    @required bookingId,
  }) async {
    try {
      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'address': {
          'addressName': address.addressName,
          'governate': address.governate,
          'area': address.area,
          'block': address.block,
          'street': address.street,
          'building': address.building,
          'paciNumber': address.paciNumber,
          'lat': address.lat,
          'long': address.long,
        },
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Get Summary Of Booking
  Stream<BookingModel> fetchBookingSummary({
    @required userId,
    @required bookingId,
  })  {
    try {
      DocumentReference documentReference = _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId);


      return documentReference.snapshots().transform(
        StreamTransformer<DocumentSnapshot, BookingModel>.fromHandlers(
          handleData: (DocumentSnapshot docs, EventSink<BookingModel> sink) {
                BookingModel booking = BookingModel.fromMap(docs.data());
            sink.add(booking);
          },
          handleError: (error, stackTrace, sink) {
            print(stackTrace);
            sink.addError(error);
          },
        ),
      );
    } catch (e) {
      print('This is an error $e');
      return null;
    }
  }

  /// Update Status of booking.
  Future<bool> updateStatusOfBooking({
    @required String userId,
    @required status,
    @required bookingId,
  }) async {
    try {
      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'status': status,
        'bookingId': bookingId,
        'userId': userId,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Update Status of booking.
  Future<bool> updateTotalPriceOfBooking({
    String userId,
    double totalPrice,
    @required bookingId,
  }) async {
    try {
      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'totalPrice': totalPrice,
        'bookingId': bookingId,
        'userId': userId,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }

  /// Get List of Bookings.
  Future<List<BookingModel>> fetchListOfBookings({@required userId}) async {
    List<BookingModel> bookingsList;
    try {
      QuerySnapshot querySnapshot =
          await _usersCollection.doc(userId).collection(Path.bookings).get();

      bookingsList = List<BookingModel>.from(
        querySnapshot.docs.map(
          (snapshot) => BookingModel.fromMap(snapshot.data()),
        ),
      );

      return bookingsList;
    } catch (e) {
      print('error in fetchListOfBookings $e');
      return null;
    }
  }

  /// Add Date To Booking List.
  Future<bool> addConfirmationTimeOfBooking({
    @required String userId,
    @required String bookingId,
    @required confirmationTime,
  }) async {
    try {
      _usersCollection
          .doc(userId)
          .collection(Path.bookings)
          .doc(bookingId)
          .set({
        'bookingId': bookingId,
        'userId': userId,
        'confirmationTime': confirmationTime,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('This is error of adding $e');
      return false;
    }
  }



}
