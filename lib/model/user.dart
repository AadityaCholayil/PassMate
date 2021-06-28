
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

  bool get isEmpty => this == UserData.empty;

  bool get isNotEmpty => this != UserData.empty;

  @override
  List<Object?> get props => [uid, email, firstName, lastName, photoUrl];

}