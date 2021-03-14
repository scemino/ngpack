import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

/// Xor key used to encode/decode ggpack files.
class XorKey {
  final String friendlyName;
  final List<int> magicBytes;
  final int multiplier;

  /// Creates a [XorKey] with a given [friendlyName], [magicBytes] and [multiplier].
  const XorKey(this.friendlyName, this.magicBytes, this.multiplier);

  @override
  String toString() => friendlyName;
}

/// Represents the ids of the known xor keys used to encode/decode ggpack files.
enum KnownXorKeyId {
  Key5b6d,
  Key566d,
  Key5bad,
  Key56ad,
  Delores,
}

/// An instance of the default implementation of the [KnownXorKeys].
const KnownXorKeys knownXorKeys = KnownXorKeys();

/// Contains all the known xor keys used to decode ggpack files.
class KnownXorKeys extends IterableBase<XorKey> {
  final _keys = const <XorKey>[
    XorKey(
        '5b6d',
        [
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
        ],
        0x6D),
    XorKey(
        '566d',
        [
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
        ],
        0x6D),
    XorKey(
        '5bad',
        [
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
        ],
        0xAD),
    XorKey(
        '56ad',
        [
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
        ],
        0xAD),
    XorKey(
        'delores',
        [
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
        ],
        0x6D),
  ];

  const KnownXorKeys();

  @override
  Iterator<XorKey> get iterator => _keys.iterator;

  /// Gets a [XorKey] from a friendly [name].
  XorKey operator [](String name) {
    return _keys.singleWhere((element) => element.friendlyName == name);
  }

  /// Gets a [XorKey] from a known [keyId].
  XorKey fromId(KnownXorKeyId keyId) {
    return this[_toName(keyId)];
  }

  static String _toName(KnownXorKeyId keyId) {
    switch (keyId) {
      case KnownXorKeyId.Key5b6d:
        return '5b6d';
      case KnownXorKeyId.Key566d:
        return '566d';
      case KnownXorKeyId.Key5bad:
        return '5bad';
      case KnownXorKeyId.Key56ad:
        return '56ad';
      case KnownXorKeyId.Delores:
        return 'delores';
      default:
        throw ArgumentError.value(keyId);
    }
  }
}

/// A [XorDecoder] converts xor encrypted data to data.
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

/// A [XorEncoder] converts data to xor encrypted data.
class XorEncoder extends Converter<Uint8List, Uint8List> {
  XorKey key;

  /// Creates a [XorEncoder] with a given [key].
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

/// A [XorCodec] encodes bytes to xor bytes and decodes xor bytes to
/// xor bytes.
class XorCodec extends Codec<Uint8List, Uint8List> {
  final XorKey key;

  /// Creates a XorCodec from a [key].
  const XorCodec(this.key);

  /// Creates a XorCodec from an [id].
  XorCodec.fromId(KnownXorKeyId id) : key = knownXorKeys.fromId(id);

  @override
  Converter<Uint8List, Uint8List> get decoder => XorDecoder(key);

  @override
  Converter<Uint8List, Uint8List> get encoder => XorEncoder(key);
}
