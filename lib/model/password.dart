import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passmate/model/auth_credentials.dart';

class Password {
  String? id;
  String path = '';
  String siteName = '';
  String siteUrl = '';
  String email = '';
  String password = '';
  String imageUrl = '';
  String note = '';
  PasswordCategory category = PasswordCategory.Others;
  bool favourite = false;
  int usage = 0;
  Timestamp? lastUsed;
  Timestamp? timeAdded;

  Password(
      {this.id = '',
      this.path = '',
      this.siteName = '',
      this.siteUrl = '',
      this.email = '',
      this.password = '',
      this.imageUrl = '',
      this.note = '',
      this.category = PasswordCategory.Others,
      this.favourite = false,
      this.usage = 0,
      this.lastUsed,
      this.timeAdded,
      });

  Password.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          path: json['path']! as String,
          siteName: json['siteName']! as String,
          siteUrl: json['siteUrl']! as String,
          email: json['email']! as String,
          password: json['password']! as String,
          imageUrl: json['imageUrl']! as String,
          note: json['note']! as String,
          category: PasswordCategory.values[json['category']! as int],
          favourite: json['favourite']! as bool,
          usage: json['usage']! as int,
          lastUsed: json['lastUsed'] as Timestamp,
          timeAdded: json['timeAdded'] as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'path': path,
      'siteName': siteName,
      'siteUrl': siteUrl,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'note': note,
      'category': category.index,
      'favourite': favourite,
      'usage': usage,
      'lastUsed': lastUsed,
      'timeAdded': timeAdded
    };
  }

  PasswordStrength get passwordStrength =>
      PasswordStrength.fromPassword(password);

  @override
  String toString(){
    return '$path - $siteName: $email, $password Category: $category, isFav: $favourite';
  }
}

enum PasswordCategory {
  All,
  Social,
  Work,
  Entertainment,
  Finance,
  Education,
  Ecommerce,
  Others,
}
