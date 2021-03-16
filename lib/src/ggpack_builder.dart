import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'ggmap_codec.dart';
import 'ggmap_encoder.dart';
import 'output_stream.dart';
import 'xor_decoder.dart';

/// A [GGPackBuilder] encodes a list of entries of type [GGPackEntry] to data.
class GGPackBuilder {
  final OutputStream _output = OutputStream();
  final List<Map<String, dynamic>> _entries = <Map<String, dynamic>>[];
  final XorKey key;
  int _offset = 8;

  /// Creates a [GGPackBuilder] with a [key].
  GGPackBuilder(this.key) {
    _output.writeInt32(0);
    _output.writeInt32(0);
  }

  /// Adds an entry [name] with specified [buffer].
  GGPackBuilder addBytes(String name, Uint8List buffer) {
    final bytes = XorEncoder(key).convert(buffer);
    var entry = {
      'filename': name,
      'offset': _offset,
      'size': buffer.lengthInBytes
    };
    _output.writeBytes(bytes);
    _offset += buffer.lengthInBytes;
    _entries.add(entry);
    return this;
  }

  /// Adds an entry [name] with specified [content].
  GGPackBuilder addContent(String name, String content) {
    return addBytes(name, Uint8List.fromList(content.codeUnits));
  }

  /// Adds an entry [name] with specified [path].
  GGPackBuilder addFile(String name, String path) {
    return addBytes(name, File(path).readAsBytesSync());
  }

  /// Adds an entry [name] with specified [map].
  GGPackBuilder addMap(String name, Map<String, dynamic> map) {
    return addBytes(name, GGMapEncoder().convert(map));
  }

  /// Builds the pack.
  Uint8List build() {
    final entriesOffset = _output.length;
    final entriesBytes = ggmap.fuse(XorCodec(key)).encode({'files': _entries});
    _output.writeBytes(entriesBytes);
    _output.position = 0;
    _output.writeInt32(entriesOffset);
    _output.writeInt32(entriesBytes.lengthInBytes);
    return _output.toBytes();
  }
}
