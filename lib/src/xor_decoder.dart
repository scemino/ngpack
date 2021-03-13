import 'dart:convert';
import 'dart:typed_data';

class XorKey {
  List<int> magicBytes;
  int multiplier;

  XorKey(this.magicBytes, this.multiplier);
}

enum KnownKey {
  Key5b6d,
  Key566d,
  Key5bad,
  Key56ad,
  KeyDelores,
}

final Keys = <KnownKey, XorKey>{
  KnownKey.Key5b6d: XorKey([
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
  KnownKey.Key566d: XorKey([
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
  KnownKey.Key5bad: XorKey([
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
  KnownKey.Key56ad: XorKey([
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
  ], 0xAD),
  KnownKey.KeyDelores: XorKey([
    0x3F,
    0x41,
    0x41,
    0x60,
    0x95,
    0x87,
    0x4A,
    0xE6,
    0x34,
    0xC6,
    0x3A,
    0x86,
    0x29,
    0x27,
    0x77,
    0x8D,
    0x38,
    0xB4,
    0x96,
    0xC9,
    0x38,
    0xB4,
    0x96,
    0xC9,
    0x00,
    0xE0,
    0x0A,
    0xC6,
    0x00,
    0xE0,
    0x0A,
    0xC6,
    0x00,
    0x3C,
    0x1C,
    0xC6,
    0x00,
    0x3C,
    0x1C,
    0xC6,
    0x00,
    0xE4,
    0x40,
    0xC6,
    0x00,
    0xE4,
    0x40,
    0xC6,
  ], 0x6D),
};

class XorDecoder extends Converter<Uint8List, Uint8List> {
  XorKey key;

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
  XorKey key;

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
