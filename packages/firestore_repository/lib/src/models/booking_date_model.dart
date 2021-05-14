import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDateModel {
  /// Name of The Day.
  String nameOfDay;

  /// Number of The Day.
  int numberOfDay;

  /// Status of Day is available or not.
  bool isAvailableDay;

  /// Start Time of Service.
  double startTime;

  /// End Time of Service.
  double endTime;

  /// Duration of Service.
  double serviceDuration;

  BookingDateModel({
    this.nameOfDay,
    this.numberOfDay,
    this.isAvailableDay,
    this.startTime,
    this.endTime,
    this.serviceDuration,
  });

  /// That use to parse data came from Firestore Document.
  factory BookingDateModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return BookingDateModel(
      nameOfDay: data['nameOfDay'],
      numberOfDay: data['numberOfDay'],
      isAvailableDay: data['isAvailableDay'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      serviceDuration: data['serviceDuration'],
    );
  }

  /// That use to parse data came from Maps.
  factory BookingDateModel.fromMap(Map data) {
    return BookingDateModel(
      nameOfDay: data['nameOfDay'],
      numberOfDay: data['numberOfDay'],
      isAvailableDay: data['isAvailableDay'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      serviceDuration: data['serviceDuration'],
    );
  }
}
