import 'dart:convert';
import 'dart:typed_data';
import 'markers.dart';
import 'output_stream.dart';

class GGMapEncoder extends Converter<Map<String, dynamic>, Uint8List> {
  final OutputStream _output = OutputStream();
  final Map<String, int> _strings = <String, int>{};

  @override
  Uint8List convert(Map<String, dynamic> input) {
    _output.writeInt32(Signature);
    _output.writeInt32(input.length);
    _output.writeInt32(0);
    writeMap(input);
    _writeKeys();
    return _output.toBytes();
  }

  bool writeValue(Object object) {
    if (object is num) {
      if (!object.isFinite) return false;
      writeNumber(object);
      return true;
    }
    if (identical(object, true)) {
      writeNumber(1);
      return true;
    }
    if (identical(object, false)) {
      writeNumber(0);
      return true;
    }
    if (object == null) {
      writeNull();
      return true;
    }
    if (object is String) {
      writeString(object);
      return true;
    }
    if (object is List) {
      writeList(object);
      return true;
    }
    if (object is Map) {
      writeMap(object);
      return true;
    }
    return false;
  }

  void writeNull() {
    _writeMarker(Markers.Null);
  }

  void writeString(String string) {
    _writeMarker(Markers.String);
    _writeRawString(string);
  }

  void writeNumber(num object) {
    final type = object is int ? Markers.Integer : Markers.Double;
    _writeMarker(type);
    _writeRawString(object.toString());
  }

  void writeList(List array) {
    _writeMarker(Markers.Array);
    _output.writeInt32(array.length);
    array.forEach(writeValue);
    _writeMarker(Markers.Array);
  }

  void writeMap(Map<String,dynamic> dictionary) {
    _writeMarker(Markers.Dictionary);
    _output.writeInt32(dictionary.length);
    dictionary.forEach((key, value) {
      _writeRawString(key);
      writeValue(value);
    });
    _writeMarker(Markers.Dictionary);
  }

  void _writeRawString(String string) {
    if (_strings.containsKey(string)) {
      _output.writeInt32(_strings[string]);
      return;
    }
    final offset = _strings.length;
    _strings[string] = offset;
    _output.writeInt32(offset);
  }

  void _writeMarker(int type) {
    _output.writeUint8(type);
  }

  void _writeKeys() {
    final plo = _output.length;
    _output.position = 8;
    _output.writeInt32(plo);
    _output.position = plo;

    // write offsets
    final strings = List<String>(_strings.length);
    _strings.forEach((key, value) {
      strings[value] = key;
    });
    _writeMarker(Markers.Offsets);
    var offset = _output.position + 4 * strings.length + 5;
    strings.forEach((value) {
      _output.writeInt32(offset);
      offset += value.length + 1;
    });
    _output.writeInt32(Markers.EndOffsets);

    // write keys
    _writeMarker(Markers.Keys);
    _strings.keys.forEach(_writeKey);
  }

  void _writeKey(String key) {
    key.codeUnits.forEach(_output.writeUint8);
    _output.writeUint8(0);
  }
}
