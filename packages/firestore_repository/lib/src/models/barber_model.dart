import 'package:cloud_firestore/cloud_firestore.dart';

/// [BarberModel] represent General Barber Model that contain
/// all details about barber.
class BarberModel {
  final String name;
  final String barberId;
  final String photoURL;
  final String email;
  final String phoneNumber;
  String bio;
  final bool isFeatured;
  final int totalOfClients;
  final double totalRating;
  final List<BarberRating> barberRating;
  final List<BarberGallery> barberGallery;
  final List<BarberServices> barberServices;

  BarberModel({
    this.name,
    this.barberId,
    this.bio,
    this.email,
    this.barberGallery,
    this.isFeatured,
    this.barberRating,
    this.barberServices,
    this.photoURL,
    this.totalOfClients,
    this.totalRating,
    this.phoneNumber
  });

  factory BarberModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return BarberModel(
      name: data['username'],
      barberId: data['barberId'],
      barberGallery: List<BarberGallery>.from(
        data['barberGallery'].map(
          (barberGallery) {
            return BarberGallery.fromMap(barberGallery);
          },
        ),
      ),
      barberRating: List<BarberRating>.from(
        data['barberRating'].map(
          (barberRating) {
            return BarberRating.fromMap(barberRating);
          },
        ),
      ),
      barberServices: List<BarberServices>.from(
        data['barberServices'].map(
          (barberServices) {
            return BarberServices.fromMap(barberServices);
          },
        ),
      ),
      isFeatured: data['isFeatured'],
      email: data['barberEmail'],
      totalRating: data['totalRating'],
      totalOfClients: data['totalOfClients'],
      photoURL: data['photoURL'],
      bio: data['bio'],
      phoneNumber: data['phoneNumber'],
    );
  }

  factory BarberModel.fromMap(Map data) {
    return BarberModel(
      name: data['username'],
      barberId: data['barberId'],
      barberGallery: data['barberGallery'],
      barberRating: data['barberRating'],
      barberServices: data['barberServices'],
      isFeatured: data['isFeatured'],
      email: data['barberEmail'],
      totalRating: data['totalRating'],
      totalOfClients: data['totalOfClients'],
      photoURL: data['photoURL'],
      bio: data['bio'],
      phoneNumber: data['phoneNumber'],

    );
  }
}

/// [BarberGallery] represent Gallery Data related to Barber.
class BarberGallery {
  final photoURL;

  BarberGallery({this.photoURL});

  factory BarberGallery.fromMap(Map<String, dynamic> data) {
    return BarberGallery(
      photoURL: data['photoURL'],
    );
  }
}

/// [BarberRating] represent barber rating.
class BarberRating {
  final ratingId;
  final int ratingNumber;
  BarberRating({this.ratingId, this.ratingNumber});

  factory BarberRating.fromMap(Map<String, dynamic> data) {
    return BarberRating(
      ratingId: data['ratingId'],
      ratingNumber: data['ratingNumber'],
    );
  }
}

/// [BarberServices] represent services that barber do.
class BarberServices {
  final String serviceName;
  final String serviceId;
  final int servicePrice;
  final serviceAvgTime;
  // final BarberRating barberRating;

  BarberServices({
    this.serviceName,
    this.serviceId,
    this.servicePrice,
    this.serviceAvgTime,
    // this.barberRating,
  });

  factory BarberServices.fromMap(Map<String, dynamic> data) {
    return BarberServices(
        serviceAvgTime: data['serviceAvgTime'],
        serviceId: data['serviceId'],
        serviceName: data['serviceName'],
        servicePrice: data['servicePrice']);
        // barberRating: data['barberRating']);
  }
}
