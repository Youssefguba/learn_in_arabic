import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableDateModel {
  final Timestamp availableDate;
  bool available;
  bool isPicked;

  AvailableDateModel({this.isPicked, this.availableDate, this.available});

  /// That use to parse data came from Firestore Document.
  factory AvailableDateModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return AvailableDateModel(
      availableDate: data['availableDate'],
      available: data['available'],
      isPicked: data['isPicked'] ?? false,
    );
  }

  /// That use to parse data came from Maps.
  factory AvailableDateModel.fromMap(Map data) {
    return AvailableDateModel(
        availableDate: data['availableDate'],
        available: data['available'],
        isPicked: data['isPicked'] ?? false,
    );
  }
}