import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/scrypt.dart';

class EncryptionRepository{

  String key = 'null';

  EncryptionRepository();

  void updateKey(String key){
    this.key = key;
    print('key updated');
  }

  static String sha256Hash(String data){
    var bytes = utf8.encode(data); // data being hashed
    var digest = sha256.convert(bytes);
    String keyStr=digest.toString().substring(0,32);
    return keyStr;
  }

  static String scryptHash(String password){
    final salt = Uint8List.fromList('y6XZ70eNLo2MkDZ7iNZW0hijoXrG3QIB'.codeUnits);
    final parameters = ScryptParameters(1024, 8, 1, 32, salt);
    final algo = Scrypt();
    algo.init(parameters);
    final data = Uint8List.fromList(password.codeUnits);
    final res = algo.process(data);
    final resStr = String.fromCharCodes(res);
    String keyStr = sha256Hash(resStr);
    return keyStr;
  }

  Future<String> encrypt(String data) async {
    String keyStr = sha256Hash(key);
    try {
      final key = Key.fromUtf8(keyStr);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      String encryptedStr = encrypter.encrypt(data, iv: iv).base64;
      return encryptedStr;
    } on Error catch (e) {
      print(e);
      return data;
    }
  }

  Future<String> decrypt(String data) async {
    String keyStr = sha256Hash(key);
    try {
      final key = Key.fromUtf8(keyStr);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      String decryptedStr=encrypter.decrypt64(data, iv: iv);
      return decryptedStr;
    } on Error catch (e) {
      print(e);
      return data;
    }
  }

  static String generateCryptoRandomString({int length = 32}) {
    Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    String key = base64Url.encode(values);
    key=key.substring(0, length);
    return key;
  }
}