import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [UserModel.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserModel extends Equatable {
  /// {@macro user}
   const UserModel(
      {@required this.userEmail,
      this.userId,
      @required this.username,
      @required this.photoURL,
      this.createdDate,
      this.favouritesList,
      this.loggedInVia,
      this.tokenId,
      this.isBlocked,
      this.phoneNumber,
      });

  /// The current user's email address.
  final String userEmail;

  /// The current user's id.
  final String userId;

  /// The current user's name (display name).
  final String username;

  /// Url for the current user's photo.
  final String photoURL;

  /// The current user's phone number.
  final String phoneNumber;

  /// The current user's Token Id.
  final int tokenId;

  /// The Date of created account.
  final createdDate;

  /// If user blocked from app or not.
  final bool isBlocked;

  /// The current user's Favourite List.
  final favouritesList;

  /// The way of user logged via [ facebook, google, email ].
  final loggedInVia;


  /// Empty user which represents an unauthenticated user.
  static const empty =
      UserModel(userEmail: '', userId: '', username: null, photoURL: null);

  @override
  List<Object> get props => [userEmail, userId, username, photoURL];

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return UserModel(
      isBlocked: data['isBlocked'],
      userId: data['userId'],
      username: data['username'],
      userEmail: data['email'],
      favouritesList: data['favouritesList'],
      photoURL: data['photoURL'],
      phoneNumber: data['phoneNumber'],
      tokenId: data['tokenId'],
      loggedInVia: data['loggedInVia'],
      createdDate: data['createdDate'],
    );
  }
  factory UserModel.fromMap(Map data) {
    return UserModel(
        isBlocked: data['isBlocked'],
        userId: data['userId'],
        username: data['username'],
        userEmail: data['email'],
        favouritesList: data['favouritesList'],
        photoURL: data['photoURL'],
        phoneNumber: data['phoneNumber'],
        tokenId: data['tokenId'],
        loggedInVia: data['loggedInVia'],
        createdDate: data['createdDate'],
    );
  }
}
