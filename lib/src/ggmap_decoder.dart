import 'dart:convert';
import 'dart:typed_data';
import 'input_stream.dart';
import 'markers.dart';

/// A [GGMapDecoder] converts data to a [Map].
class GGMapDecoder extends Converter<Uint8List, Map<String, dynamic>> {
  int? numKeys;
  late InputStream _input;
  late List<int> _offsets;

  GGMapDecoder();

  @override
  Map<String, dynamic> convert(Uint8List input) {
    _input = InputStream(ByteData.sublistView(input));

    // check signature
    final signature = _input.readUint32();
    if (signature != Signature) {
      throw Exception('This is NOT a valid ggpack file :(');
    }
    numKeys = _input.readUint32();
    _offsets = _readPlo(_input);

    _input = InputStream(ByteData.sublistView(input, 12));

    return _readHash();
  }

  static List<int> _readPlo(InputStream input) {
    final offsets = <int>[];
    var ploIndex = input.readUint32();
    input.seek(ploIndex);
    var c = input.readUint8();
    if (c != Markers.Offsets) {
      throw Exception('GGPack cannot find plo :(');
    }
    do {
      final offset = input.readUint32();
      if (offset == Markers.EndOffsets) break;
      offsets.add(offset);
    } while (true);
    return offsets;
  }

  List _readArray() {
    var c = _input.readUint8();
    if (c != Markers.Array) {
      throw Exception('trying to parse a non-array');
    }
    var array = [];
    final length = _input.readUint32();
    for (var i = 0; i < length; i++) {
      final item = _readValue();
      array.add(item);
    }
    c = _input.readUint8();
    if (c != Markers.Array) {
      throw Exception('unterminated array');
    }
    return array;
  }

  Map<String, dynamic> _readHash() {
    var c = _input.readUint8();
    if (c != Markers.Dictionary) {
      throw Exception('trying to parse a non-hash');
    }
    final nPairs = _input.readUint32();
    var map = <String, dynamic>{};
    for (var i = 0; i < nPairs; i++) {
      final key = _readString(_input.readUint32());
      final value = _readValue();
      map[key] = value;
    }
    c = _input.readUint8();
    if (c != Markers.Dictionary) {
      throw Exception('unterminated hash');
    }
    return map;
  }

  String _readString(int index) {
    final pos = _input.position;
    _input.seek(_offsets[index] - 12);
    var charCodes = <int>[];
    do {
      final c = _input.readUint8();
      if (c == 0) break;
      charCodes.add(c);
    } while (true);
    _input.seek(pos);
    return String.fromCharCodes(charCodes);
  }

  dynamic _readValue() {
    final type = _input.readUint8();
    switch (type) {
      case Markers.Null:
        return null;
      case Markers.Dictionary:
        _input.seek(_input.position - 1);
        return _readHash();
      case Markers.Array:
        _input.seek(_input.position - 1);
        return _readArray();
      case Markers.String:
        {
          final ploIdx = _input.readUint32();
          return _readString(ploIdx);
        }
      case Markers.Integer:
      case Markers.Double:
        {
          final ploIdx = _input.readUint32();
          final num_str = _readString(ploIdx);
          if (type == Markers.Integer) {
            return int.parse(num_str);
          }
          return double.parse(num_str);
        }
      default:
        {
          throw 'Not Implemented: value type $type';
        }
    }
  }
}
