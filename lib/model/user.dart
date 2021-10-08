import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passmate/model/sort_methods.dart';

class UserData extends Equatable {
  final String uid;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final bool? pinSet;
  final SortMethod? sortMethod;

  const UserData(
      {required this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.pinSet,
      this.sortMethod});

  static UserData fromUser(User user) {
    return UserData(uid: user.uid, email: user.email);
  }

  static UserData empty = const UserData(uid: '');

  UserData.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          email: json['email']! as String,
          firstName: json['firstName']! as String,
          lastName: json['lastName']! as String,
          photoUrl: json['photoUrl']! as String,
          pinSet: json['pinSet']! as bool,
          sortMethod: SortMethod.values[json['sortMethod']! as int],
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'pinSet': pinSet,
      'sortMethod': sortMethod?.index ?? 0,
    };
  }

  bool get isEmpty => this == UserData.empty;

  bool get isNotEmpty => this != UserData.empty;

  @override
  String toString() {
    return 'uid: $uid, email: $email, name: $firstName $lastName, photoUrl: $photoUrl';
  }

  @override
  List<Object?> get props =>
      [uid, email, firstName, lastName, photoUrl, pinSet, sortMethod];
}
