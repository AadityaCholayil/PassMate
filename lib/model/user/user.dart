import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/user/sort_methods.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    @Default('') String uid,
    String? email,
    String? firstName,
    String? lastName,
    String? photoUrl,
    bool? pinSet,
    SortMethod? sortMethod,
    List<String>? folderList,
  }) = _User;

  factory User.fromDoc(DocumentSnapshot doc) {
    User user = User.fromJson(doc.data() as Map<String, dynamic>? ?? {});
    return user.copyWith(uid: doc.id);
  }

  Map<String, dynamic> toDoc() {
    Map<String, dynamic> map = toJson();
    map.remove('uid');
    return map;
  }

  factory User.fromUser(auth.User authUser) {
    return User(uid: authUser.uid, email: authUser.email);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
