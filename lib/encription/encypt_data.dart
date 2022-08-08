import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class EncryptData {
  //for AES Algorithms
  static Encrypted? encrypted;
  static var decrypted;
  static encyptAES(plaintText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encypter = Encrypter(AES(key));
    encrypted = encypter.encrypt(plaintText, iv: iv);
    print(encrypted!.base16);
  }

  static decyptAES(plaintText) {
    print('Plain text $plaintText');
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(Encrypted.fromBase16(plaintText), iv: iv);
    print("decrypted $decrypted");
  }
}
