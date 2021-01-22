import 'package:encrypt/encrypt.dart';

class DataEncrypter {
  final _key = Key.fromUtf8('m4&KmsrgYh/A``(K^(zg@,JB*fL.aMJm');
  final iv = IV.fromLength(16);
  Encrypter _encrypter;

  DataEncrypter() {
    _encrypter = Encrypter(AES(_key));
  }

  String encrypt(String plainText) {
    return _encrypter.encrypt(plainText, iv: iv).base64;
  }

  String decrypt(String encryptedText) {
    return _encrypter
        .decrypt(Encrypted.fromBase64(encryptedText), iv: iv)
        .toString();
  }
}
