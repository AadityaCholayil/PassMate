import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/user/sort_methods.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User(
    final String uid,
    final String? email,
    final String? firstName,
    final String? lastName,
    final String? photoUrl,
    final bool? pinSet,
    final SortMethod? sortMethod,
  ) = _User;

  factory User.fromDoc(DocumentSnapshot doc) {
    User user = User.fromJson(doc.data() as Map<String, dynamic>? ?? {});
    return user.copyWith(uid: doc.id);
  }

  Map<String, dynamic> toDoc() {
    Map<String, dynamic> map = toJson();
    map.remove('id');
    return map;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
