// import 'package:equatable/equatable.dart';

// class Password extends Equatable {
//   final String? id;
//   final String? path;
//   final String? siteName;
//   final String? siteUrl;
//   final String? email;
//   final String? password;
//   final String? imageUrl;
//   final String? note;
//   final int? category;
//   final bool? favourite;
//   final int? usage;
//   final DateTime? lastUsed;
//   final DateTime? timeAdded;

//   const Password({
//     this.id,
//     this.path,
//     this.siteName,
//     this.siteUrl,
//     this.email,
//     this.password,
//     this.imageUrl,
//     this.note,
//     this.category,
//     this.favourite,
//     this.usage,
//     this.lastUsed,
//     this.timeAdded,
//   });

//   factory Password.fromMap(Map<String, dynamic> data, String id) => Password(
//         id: id,
//         path: data['path'] as String?,
//         siteName: data['siteName'] as String?,
//         siteUrl: data['siteUrl'] as String?,
//         email: data['email'] as String?,
//         password: data['password'] as String?,
//         imageUrl: data['imageUrl'] as String?,
//         note: data['note'] as String?,
//         category: data['category'] as int?,
//         favourite: data['favourite'] as bool?,
//         usage: data['usage'] as int?,
//         lastUsed: data['lastUsed'] == null
//             ? null
//             : DateTime.parse(data['lastUsed'] as String),
//         timeAdded: data['timeAdded'] == null
//             ? null
//             : DateTime.parse(data['timeAdded'] as String),
//       );

//   Map<String, dynamic> toMap() => {
//         'path': path,
//         'siteName': siteName,
//         'siteUrl': siteUrl,
//         'email': email,
//         'password': password,
//         'imageUrl': imageUrl,
//         'note': note,
//         'category': category,
//         'favourite': favourite,
//         'usage': usage,
//         'lastUsed': lastUsed?.toIso8601String(),
//         'timeAdded': timeAdded?.toIso8601String(),
//       };

//   Password copyWith({
//     String? id,
//     String? path,
//     String? siteName,
//     String? siteUrl,
//     String? email,
//     String? password,
//     String? imageUrl,
//     String? note,
//     int? category,
//     bool? favourite,
//     int? usage,
//     DateTime? lastUsed,
//     DateTime? timeAdded,
//   }) {
//     return Password(
//       path: path ?? this.path,
//       siteName: siteName ?? this.siteName,
//       siteUrl: siteUrl ?? this.siteUrl,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       imageUrl: imageUrl ?? this.imageUrl,
//       note: note ?? this.note,
//       category: category ?? this.category,
//       favourite: favourite ?? this.favourite,
//       usage: usage ?? this.usage,
//       lastUsed: lastUsed ?? this.lastUsed,
//       timeAdded: timeAdded ?? this.timeAdded,
//     );
//   }

//   @override
//   bool get stringify => true;

//   @override
//   List<Object?> get props {
//     return [
//       path,
//       siteName,
//       siteUrl,
//       email,
//       password,
//       imageUrl,
//       note,
//       category,
//       favourite,
//       usage,
//       lastUsed,
//       timeAdded,
//     ];
//   }
// }
