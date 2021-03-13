import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'ggmap_decoder.dart';
import 'ggpack_entry.dart';
import 'input_stream.dart';
import 'xor_decoder.dart';
import 'package:path/path.dart' as path;
import 'package:ngpack/src/bnut_decoder.dart';

/// A [GGPackFileDecoder] decodes data into a list of entries of type [GGPackEntry].
class GGPackFileDecoder extends IterableBase<GGPackEntry> {
  final XorKey key;
  late InputStream _input;
  late List<GGPackEntry> _entries;

  /// Creates a [GGPackFileDecoder] with a [key].
  GGPackFileDecoder(Uint8List data, this.key) {
    final input = data.buffer.asUint32List(0);
    final entriesOffset = input[0];
    final entriesSize = input[1];

    // decode entries
    final entriesData = data.buffer.asUint8List(entriesOffset, entriesSize);
    final bytes = XorDecoder(key).convert(entriesData);

    // read entries as hash
    final entries = GGMapDecoder().convert(bytes);
    _entries = <GGPackEntry>[];
    entries['files'].forEach((e) {
      _entries.add(GGPackEntry(e['filename'], e['offset'], e['size']));
    });

    // create stream to be able to extract entries
    _input = InputStream(ByteData.sublistView(data));
  }

  /// Creates a [GGPackFileDecoder] from a [path] and a [key].
  factory GGPackFileDecoder.fromFile(String path, XorKey key) {
    final bytes = File(path).readAsBytesSync();
    return GGPackFileDecoder(bytes, key);
  }

  GGPackEntry operator [](int index) => _entries[index];

  @override
  Iterator<GGPackEntry> get iterator => _entries.iterator;

  /// Extracts the content of the entry [name].
  String extractContent(String name) {
    return utf8.decode(Uint8List.fromList(extract(name)));
  }

  /// Extracts the entry [name] to a [Map].
  Map<String, dynamic> extractMap(String name) {
    return json.decode(utf8.decode(Uint8List.fromList(extract(name))));
  }

  /// Extracts the entry [name] to data.
  List<int> extract(String name, [bool convert = true]) {
    final entry = _entries.firstWhere((element) => element.filename == name);
    final bytes = _input.data.buffer.asUint8List(entry.offset, entry.size);
    final decodedData = XorDecoder(key).convert(bytes);

    if (!convert) return decodedData;

    final ext = path.extension(name).toLowerCase();
    if (ext == '.wimpy') {
      final wimpy = GGMapDecoder().convert(decodedData);
      final jObject = JsonEncoder.withIndent('  ').convert(wimpy);
      return utf8.encode(jObject);
    }
    if (ext == '.bnut') {
      return BnutDecoder().convert(decodedData);
    }
    return decodedData;
  }
}
