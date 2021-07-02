import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData extends Equatable{

  final String uid;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;

  UserData({required this.uid, this.email, this.firstName, this.lastName,
    this.photoUrl});

  static UserData fromUser(User user){
    return UserData(uid: user.uid, email: user.email);
  }

  static UserData empty = UserData(uid: '');

  UserData.fromJson(Map<String, Object?> json)
      : this(
    uid: json['uid']! as String,
    email: json['uid']! as String,
    firstName: json['uid']! as String,
    lastName: json['uid']! as String,
    photoUrl: json['uid']! as String,
  );

  Map<String, Object?> toJson(){
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
    };
  }

  bool get isEmpty => this == UserData.empty;

  bool get isNotEmpty => this != UserData.empty;

  @override
  List<Object?> get props => [uid, email, firstName, lastName, photoUrl];

}