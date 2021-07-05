import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/scrypt.dart';

class EncryptionRepository{

  String key = 'Bruh moment';

  EncryptionRepository();

  void updateKey(String key){
    this.key = key;
    print('key updated');
  }

  static String scryptHash(String password){
    final salt = Uint8List.fromList('y6XZ70eNLo2MkDZ7iNZW0hijoXrG3QIB'.codeUnits);
    final parameters = ScryptParameters(1024, 8, 1, 32, salt);
    final algo = Scrypt();
    algo.init(parameters);
    final data = Uint8List.fromList(password.codeUnits);
    final res = algo.process(data);
    final resStr = String.fromCharCodes(res);
    return resStr;
  }

  Future<String> encrypt(String data) async {
    String keyStr = key;
    try {
      final key = Key.fromUtf8(keyStr);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      String encryptedStr='';
      encryptedStr=encrypter.encrypt(data, iv: iv).base64;
      return encryptedStr;
    } on Error catch (e) {
      print(e);
      return data;
    }
  }

  Future<String> decrypt(String password, String data) async {
    String keyStr= '';
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha256.convert(bytes);
    print('$digest, ${digest.toString().length}');
    keyStr=digest.toString().substring(0,32);
    print('$keyStr, ${keyStr.toString().length}');
    try {
      final key = Key.fromUtf8(keyStr);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      String decryptedStr='';
      decryptedStr=encrypter.decrypt64(data, iv: iv);
      return decryptedStr;
    } on Error catch (e) {
      print(e);
      return data;
    }
  }


}