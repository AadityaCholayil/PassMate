import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class OldSecureNote {
  String id;
  String path;
  String title;
  String content;
  bool favourite;
  int usage;
  Timestamp? lastUsed;
  Timestamp? timeAdded;

  OldSecureNote({
    this.id = '',
    this.path = '',
    this.title = '',
    this.content = '',
    this.favourite = false,
    this.usage = 0,
    this.lastUsed,
    this.timeAdded,
  });

  OldSecureNote.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          path: json['path']! as String,
          title: json['title']! as String,
          content: json['content']! as String,
          favourite: json['favourite']! as bool,
          usage: json['usage']! as int,
          lastUsed: json['lastUsed'] as Timestamp,
          timeAdded: json['timeAdded'] as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'path': path,
      'title': title,
      'content': content,
      'favourite': favourite,
      'usage': usage,
      'lastUsed': lastUsed,
      'timeAdded': timeAdded,
    };
  }

  Future encrypt(EncryptionRepository encryptionRepository) async {
    title = await encryptionRepository.encrypt(title);
    content = await encryptionRepository.encrypt(content);
  }

  Future decrypt(EncryptionRepository encryptionRepository) async {
    title = await encryptionRepository.decrypt(title);
    content = await encryptionRepository.decrypt(content);
  }

  @override
  String toString() {
    return '$path - $title: $content, isFav: $favourite';
  }
}
