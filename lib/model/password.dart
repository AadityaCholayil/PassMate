import 'package:passmate/model/auth_credentials.dart';

class Password {
  String? id;
  String path = '';
  String siteName = '';
  String siteUrl = '';
  String email = '';
  String password = '';
  String note = '';
  PasswordCategory category = PasswordCategory.Others;
  bool favourite = false;
  int usage = 0;

  Password(
      {this.id = '',
      this.path = '',
      this.siteName = '',
      this.siteUrl = '',
      this.email = '',
      this.password = '',
      this.note = '',
      this.category = PasswordCategory.Others,
      this.favourite = false,
      this.usage = 0});

  Password.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          path: json['path']! as String,
          siteName: json['siteName']! as String,
          siteUrl: json['siteUrl']! as String,
          email: json['email']! as String,
          password: json['password']! as String,
          note: json['note']! as String,
          category: PasswordCategory.values[json['category']! as int],
          favourite: json['favourite']! as bool,
          usage: json['usage']! as int,
        );

  Map<String, Object?> toJson(String uid) {
    return {
      'uid': uid,
      'path': path,
      'siteName': siteName,
      'siteUrl': siteUrl,
      'email': email,
      'password': password,
      'note': note,
      'category': category.index,
      'favourite': favourite,
      'usage': usage,
    };
  }

  PasswordStrength get passwordStrength =>
      PasswordStrength.fromPassword(password);
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
