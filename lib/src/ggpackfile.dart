import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'gghashreader.dart';
import 'ggpackentry.dart';
import 'inputstream.dart';
import 'package:path/path.dart' as path;

class GGPackFile extends IterableBase<GGPackEntry> {
  InputStream _input;
  List<GGPackEntry> _entries;

  GGPackFile(ByteData data) {
    _input = InputStream(data);

    final dataOffset = _input.readUint32();
    final dataSize = _input.readUint32();

    // decode data
    final bytes = ByteData.sublistView(data, dataOffset, dataOffset + dataSize);
    _decodeUnbreakableXor(bytes);

    // check signature
    final signature = bytes.getUint32(0, Endian.little);
    if (signature != 0x04030201) {
      throw Exception('This is NOT a valid ggpack file :(');
    }

    final entries = GGHashReader(bytes).read();
    _entries = [];
    entries['files'].getArray().forEach((e) {
      var entry = GGPackEntry();
      entry.filename = e['filename'].getString();
      entry.offset = e['offset'].getInt();
      entry.size = e['size'].getInt();
      _entries.add(entry);
    });
  }

  GGPackEntry operator [](int index) => _entries[index];

  Iterator<GGPackEntry> get iterator => _entries.iterator;

  List<int> extract(String name) {
    final entry = _entries.firstWhere((element) => element.filename == name);
    if (entry == null) return null;
    final data = ByteData.view(_input.data.buffer, entry.offset, entry.size);
    final bytes = data.buffer
        .asUint8List(data.offsetInBytes, data.lengthInBytes)
        .toList();
    final copyData = ByteData.sublistView(Uint8List.fromList(bytes));
    _decodeUnbreakableXor(copyData);
    

    if(path.extension(name) == '.wimpy'){
      final wimpy = GGHashReader(copyData).read();
      final json = JsonEncoder.withIndent('  ').convert(wimpy);
      return utf8.encode(json);
    }
    final result = copyData.buffer
        .asUint8List(copyData.offsetInBytes, copyData.lengthInBytes)
        .toList();
    return result;
  }

  void _decodeUnbreakableXor(ByteData buffer) {
    const magicBytes = [
      0x4f,
      0xd0,
      0xa0,
      0xac,
      0x4a,
      0x5b,
      0xb9,
      0xe5,
      0x93,
      0x79,
      0x45,
      0xa5,
      0xc1,
      0xcb,
      0x31,
      0x93
    ];
    final code = 0xad;
    final length = buffer.lengthInBytes;
    var previous = length & 0xff;
    for (var i = 0; i < length; i++) {
      final x = (buffer.getUint8(i) ^ magicBytes[i & 0xf] ^ (i * code));
      buffer.setUint8(i, x ^ previous);
      previous = x;
    }

    //Loop through in blocks of 16 and xor the 6th and 7th bytes
    var i = 5;
    while (i < length) {
      buffer.setUint8(i, buffer.getUint8(i) ^ 0x0d);
      if (i + 1 < length) {
        buffer.setUint8(i + 1, buffer.getUint8(i + 1) ^ 0x0d);
      }
      i += 16;
    }
  }
}

