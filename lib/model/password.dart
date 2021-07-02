import 'package:passmate/model/auth_credentials.dart';

class Password {
  String siteName = '';
  String siteUrl = '';
  String email = '';
  String password = '';
  String note = '';
  PasswordCategory category = PasswordCategory.Others;
  bool favourite = false;
  int usage = 0;

  Password(
      {this.siteName = '',
      this.siteUrl = '',
      this.email = '',
      this.password = '',
      this.note = '',
      this.category = PasswordCategory.Others,
      this.favourite = false,
      this.usage = 0});

  Password.fromJson(Map<String, Object?> json)
      : this(
    siteName: json['siteName']! as String,
    siteUrl: json['siteUrl']! as String,
    email: json['email']! as String,
    password: json['password']! as String,
    note: json['note']! as String,
    category: PasswordCategory.values[json['category']! as int] ,
    favourite: json['favourite']! as bool,
    usage: json['usage']! as int,
  );

  Map<String, Object?> toJson(){
    return {
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

  // Password password1 = Password(
  //   siteName: 'Google',
  //   siteUrl: 'www.google.com',
  //   email: 'aaditya@xyz.com',
  //   password: 'aadi123',
  //   note: 'Bruh',
  //   category: PasswordCategory.Entertainment,
  //   favourite: false,
  //   usage: 3
  // );
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
