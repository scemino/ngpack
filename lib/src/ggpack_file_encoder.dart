import 'dart:io';
import 'dart:typed_data';

import 'ggmap_encoder.dart';
import 'output_stream.dart';
import 'xor_decoder.dart';

class GGPackFileEncoder {
  final OutputStream _output = OutputStream();
  final List<Map<String, dynamic>> _entries = <Map<String, dynamic>>[];
  final XorKey key;
  int _offset = 8;

  GGPackFileEncoder(this.key) {
    _output.writeInt32(0);
    _output.writeInt32(0);
  }

  void addBytes(String name, Uint8List buffer) {
    final bytes = XorEncoder(key).convert(buffer);
    var entry = {
      'filename': name,
      'offset': _offset,
      'size': buffer.lengthInBytes
    };
    _output.writeBytes(bytes);
    _offset += buffer.lengthInBytes;
    _entries.add(entry);
  }

  void addContent(String name, String content) {
    addBytes(name, Uint8List.fromList(content.codeUnits));
  }

  void addFile(String name, String path) {
    addBytes(name, File(path).readAsBytesSync());
  }

  void addMap(String name, Map<String, dynamic> map) {
    addBytes(name, GGMapEncoder().convert(map));
  }

  Uint8List toBytes() => _output.toBytes();

  void close() {
    final entriesOffset = _output.length;
    final entries = <String, dynamic>{};
    entries['files'] = _entries;
    final entriesData = GGMapEncoder().convert(entries);
    final entriesBytes = XorEncoder(key).convert(entriesData);
    _output.writeBytes(entriesBytes);
    _output.position = 0;
    _output.writeInt32(entriesOffset);
    _output.writeInt32(entriesBytes.lengthInBytes);
  }
}
