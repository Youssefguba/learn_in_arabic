import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  /// The Id of service
  // String serviceId;

  /// The name of service.
  String serviceName;

  /// the number of people will book this service.
  int numOfPeople;

  /// the time of service will taken.
  int timeOfService;

  /// the price of service
  int priceOfService;

  /// rating of this service
  // double ratingOfService;

  ServiceModel({
    this.serviceName,
    // this.serviceId,
    this.numOfPeople,
    this.priceOfService,
    // this.ratingOfService,
    this.timeOfService,
  });

  /// That use to parse data came from Firestore Document.
  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return ServiceModel(
      // serviceId: data['serviceId'],
      serviceName: data['serviceName'],
      priceOfService: data['priceOfService'],
      numOfPeople: data['numOfPeople'],
      // ratingOfService: data['ratingOfService'],
      timeOfService: data['timeOfService'],
    );
  }

  /// That use to parse data came from Maps.
  factory ServiceModel.fromMap(Map data) {
    return ServiceModel(
      // serviceId: data['serviceId'],
      serviceName: data['serviceName'],
      priceOfService: data['priceOfService'],
      numOfPeople: data['numOfPeople'],
      // ratingOfService: data['ratingOfService'],
      timeOfService: data['timeOfService'],
    );
  }

  Map<String, dynamic> toJson() => {
        'serviceName': serviceName,
        'priceOfService': priceOfService,
        'numOfPeople': numOfPeople,
        'timeOfService': timeOfService,
      };
}
