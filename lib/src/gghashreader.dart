import 'dart:typed_data';
import 'ggpackvalue.dart';
import 'inputstream.dart';

class GGHashReader {
  InputStream _input;
  List<int> _offsets;

  GGHashReader(ByteData data) {
    _offsets = [];

    // read plo
    _input = InputStream(data);
    _readPlo();

    _input = InputStream(ByteData.sublistView(data, 12));
  }

  GGPackValue read() {
    return _readHash();
  }

  void _readPlo() {
    _input.seek(8);
    var ploIndex = _input.readUint32();
    _input.seek(ploIndex);
    var c = _input.readUint8();
    if (c != 7) {
      print('GGPack cannot find plo :(');
      return;
    }
    do {
      final offset = _input.readUint32();
      if (offset == 0xFFFFFFFF) break;
      _offsets.add(offset);
    } while (true);
  }

  GGPackValue _readArray() {
    var c = _input.readUint8();
    if (c != 3) {
      throw Exception('trying to parse a non-array');
    }
    var array = [];
    final length = _input.readUint32();
    for (var i = 0; i < length; i++) {
      final item = _readValue();
      array.add(item);
    }
    c = _input.readUint8();
    if (c != 3) {
      throw Exception('unterminated array');
    }
    return GGPackValue.fromArray(array.cast<GGPackValue>());
  }

  GGPackValue _readHash() {
    var c = _input.readUint8();
    if (c != 2) {
      throw Exception('trying to parse a non-hash');
    }
    final nPairs = _input.readUint32();
    var map = Map<String, GGPackValue>();
    for (var i = 0; i < nPairs; i++) {
      final keyIdx = _input.readUint32();
      final key = _readString(keyIdx);
      final value = _readValue();
      map[key] = value;
    }
    c = _input.readUint8();
    if (c != 2) {
      throw Exception('unterminated hash');
    }
    return GGPackValue.fromMap(map);
  }

  String _readString(int index) {
    final pos = _input.position;
    _input.seek(_offsets[index] - 12);
    var charCodes = [];
    do {
      final c = _input.readUint8();
      if (c == 0) break;
      charCodes.add(c);
    } while (true);
    _input.seek(pos);
    return String.fromCharCodes(charCodes.cast<int>());
  }

  GGPackValue _readValue() {
    final type = _input.readUint8();
    switch (type) {
      case 1:
        // null
        return GGPackValue();
      case 2:
        // hash
        _input.seek(_input.position - 1);
        return _readHash();
      case 3:
        // array
        _input.seek(_input.position - 1);
        return _readArray();
      case 4:
        // string
        {
          final ploIdx = _input.readUint32();
          return GGPackValue.fromString(_readString(ploIdx));
        }
      case 5:
      case 6:
        {
          // int
          // double
          final ploIdx = _input.readUint32();
          final num_str = _readString(ploIdx);
          if (type == 5) {
            return GGPackValue.fromInt(int.parse(num_str));
          }
          return GGPackValue.fromDouble(double.parse(num_str));
        }
      default:
        {
          throw 'Not Implemented: value type $type';
        }
    }
  }
}
