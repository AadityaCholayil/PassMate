import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class Password {
  String id;
  String path;
  String siteName;
  String siteUrl;
  String email;
  String password;
  String imageUrl;
  String note;
  PasswordCategory category;
  bool favourite;
  int usage;
  Timestamp? lastUsed;
  Timestamp? timeAdded;

  Password({
    this.id = '',
    this.path = '',
    this.siteName = '',
    this.siteUrl = '',
    this.email = '',
    this.password = '',
    this.imageUrl = '',
    this.note = '',
    this.category = PasswordCategory.others,
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

  Future encrypt(EncryptionRepository encryptionRepository) async {
    siteName = await encryptionRepository.encrypt(siteName);
    siteUrl = await encryptionRepository.encrypt(siteUrl);
    email = await encryptionRepository.encrypt(email);
    password = await encryptionRepository.encrypt(password);
    imageUrl = await encryptionRepository.encrypt(imageUrl);
    note = await encryptionRepository.encrypt(note);
  }

  Future decrypt(EncryptionRepository encryptionRepository) async {
    siteName = await encryptionRepository.decrypt(siteName);
    siteUrl = await encryptionRepository.decrypt(siteUrl);
    email = await encryptionRepository.decrypt(email);
    password = await encryptionRepository.decrypt(password);
    imageUrl = await encryptionRepository.decrypt(imageUrl);
    note = await encryptionRepository.decrypt(note);
  }

  void printDetails(){
    print('$id, $path, $siteName, $siteUrl, $email, $password, $imageUrl, $note,'
        ' $category, $favourite, $usage, $lastUsed, $timeAdded');
  }

  @override
  String toString() {
    return '$path - $siteName: $email, $password Category: $category, isFav: $favourite';
  }
}

// class PasswordCategory {
//   final String label;
//   final String icon;
//
//   PasswordCategory({required this.label, required this.icon});
//
//
// }


enum PasswordCategory {
  all,
  social,
  work,
  entertainment,
  finance,
  education,
  ecommerce,
  others,
}

Map<String, IconData> passwordCategoryIcon = {
  'Favourites': Icons.favorite_border_rounded,
  'Social': Icons.people_alt_outlined,
  'Work': Icons.work_outline,
  'Entertainment': Icons.movie_creation_outlined,
  'Finance': Icons.attach_money,
  'Education': Icons.school_outlined,
  'Ecommerce': Icons.shopping_cart_outlined,
  'Others': Icons.more_horiz
};

String getPasswordCategoryStr(PasswordCategory passwordCategory){
  String label = passwordCategory.toString().substring(17);
  return label.replaceRange(0, 1, label.substring(0, 1).toUpperCase());
}
