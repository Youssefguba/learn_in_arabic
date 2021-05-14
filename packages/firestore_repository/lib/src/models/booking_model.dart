
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:firestore_repository/src/models/service_model.dart';


/// This Booking Model Class contains
class BookingModel {
  /// Services
  List<ServiceModel> serviceModel;

  /// from Time
  Timestamp fromTime;

  /// To Time
  Timestamp toTime;

  /// Booking Date
  Timestamp bookingDate;

  /// status of booking
  String statusOfBooking;

  /// Address
  AddressModel address;

  /// Barber Id
  String barberId;

  /// user Id
  String userId;

  /// Total price of services.
  double totalPrice;

  /// Booking Id
  String bookingId;

  /// Confirmation Time
  Timestamp confirmationTime;


  BookingModel({
    this.serviceModel,
    this.address,
    this.bookingDate,
    this.fromTime,
    this.toTime,
    this.statusOfBooking,
    this.barberId,
    this.userId,
    this.totalPrice,
    this.bookingId,
    this.confirmationTime
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return BookingModel(
        serviceModel: List<ServiceModel>.from(
          data['services'].map(
            (serviceModel) {
              return ServiceModel.fromMap(serviceModel);
            },
          ),
        ),
        address: AddressModel.fromMap(data["address"]),
        bookingDate: data['bookingDate'],
        fromTime: data['fromTime'],
        toTime: data['toTime'],
        statusOfBooking: data['status'],
        barberId: data['barberId'],
        userId: data['userId'],
        totalPrice: data['totalPrice'],
        bookingId: data['bookingId'],
        confirmationTime: data['confirmationTime'],
    );
  }

  factory BookingModel.fromMap(Map data) {
    return BookingModel(
      fromTime: data["fromTime"],
      bookingDate: data["bookingDate"],
      serviceModel: List<ServiceModel>.from(data["services"].map((x) => ServiceModel.fromMap(x))),
      toTime: data["toTime"],
      statusOfBooking: data['status'],
      barberId: data['barberId'],
      userId: data['userId'],
      totalPrice: data['totalPrice'],
      address: AddressModel.fromMap(data["address"]),
      bookingId: data['bookingId'],
      confirmationTime: data['confirmationTime'],

    );
  }
}
