import 'dart:convert';
import 'dart:typed_data';

class Key {
  List<int> magicBytes;
  int multiplier;

  Key(this.magicBytes, this.multiplier);
}

enum KnownKey {
  Key5b6d,
  Key566d,
  Key5bad,
  Key56ad,
}

final Keys = <KnownKey, Key>{
  KnownKey.Key5b6d: Key([
    0x4F,
    0xD0,
    0xA0,
    0xAC,
    0x4A,
    0x5B,
    0xB9,
    0xE5,
    0x93,
    0x79,
    0x45,
    0xA5,
    0xC1,
    0xCB,
    0x31,
    0x93,
  ], 0x6D),
  KnownKey.Key566d: Key([
    0x4F,
    0xD0,
    0xA0,
    0xAC,
    0x4A,
    0x56,
    0xB9,
    0xE5,
    0x93,
    0x79,
    0x45,
    0xA5,
    0xC1,
    0xCB,
    0x31,
    0x93
  ], 0x6D),
  KnownKey.Key5bad: Key([
    0x4F,
    0xD0,
    0xA0,
    0xAC,
    0x4A,
    0x5B,
    0xB9,
    0xE5,
    0x93,
    0x79,
    0x45,
    0xA5,
    0xC1,
    0xCB,
    0x31,
    0x93,
  ], 0xAD),
  KnownKey.Key56ad: Key([
    0x4F,
    0xD0,
    0xA0,
    0xAC,
    0x4A,
    0x56,
    0xB9,
    0xE5,
    0x93,
    0x79,
    0x45,
    0xA5,
    0xC1,
    0xCB,
    0x31,
    0x93,
  ], 0xAD)
};

class XorDecoder extends Converter<Uint8List, Uint8List> {
  Key key;

  XorDecoder(this.key);

  @override
  Uint8List convert(Uint8List data) {
    var builder = BytesBuilder();
    var previous = data.length & 0xFF;
    for (var i = 0; i < data.length; ++i) {
      var x = data[i] ^ key.magicBytes[i & 0x0F] ^ (i * key.multiplier);
      builder.addByte(x ^ previous);
      previous = x;
    }
    return builder.toBytes();
  }
}

class XorEncoder extends Converter<Uint8List, Uint8List> {
  Key key;

  XorEncoder(this.key);

  @override
  Uint8List convert(Uint8List data) {
    var builder = BytesBuilder();
    var previous = data.length & 0xFF;
    for (var i = 0; i < data.length; ++i) {
      var x = data[i] ^ previous;
      builder.addByte(x ^ key.magicBytes[i & 0x0F] ^ (i * key.multiplier));
      previous = x;
    }
    return builder.toBytes();
  }
}
