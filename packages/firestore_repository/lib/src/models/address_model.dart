import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class AddressModel {
  AddressModel({
  @required this.addressName,
  @required this.governate,
  @required this.area,
  @required this.block,
  @required this.street,
  @required this.building,
  @required this.paciNumber,
  @required this.lat,
  @required this.long,
  });

  /// Name of Address.
  final String addressName;

  /// The governate of address
  final String governate;

  /// the area inside governate
  final String area;

  /// number of bloc
  final String block;

  /// name of street
  final String street;

  /// number of building
  final String building;

  /// number of floor
  String floor;

  /// number of apartment
  String apartment;

  /// paci number that show on apartment.
  final String paciNumber;

  /// latitude that came from google maps.
  final double lat;

  /// longitude that came from google maps.
  final double long;

  /// That use to parse data came from Firestore Document.
  factory AddressModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return AddressModel(
      addressName: data['addressName'],
      governate: data['governate'],
      area: data['area'],
      block: data['block'],
      street: data['street'],
      building: data['building'],
      paciNumber: data['paciNumber'],
      lat: data['lat'],
      long: data['long'],
    );
  }

  /// That use to parse data came from Maps.
  factory AddressModel.fromMap(Map data) {
    return AddressModel(
      addressName: data['addressName'],
      governate: data['governate'],
      area: data['area'],
      block: data['block'],
      street: data['street'],
      building: data['building'],
      paciNumber: data['paciNumber'],
      lat: data['lat'],
      long: data['long'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'addressName': addressName,
        'governate': governate,
        'area': area,
        'block': block,
        'street': street,
        'building': building,
        'paciNumber': paciNumber,
        'lat': lat,
        'long': long,
      };
}
