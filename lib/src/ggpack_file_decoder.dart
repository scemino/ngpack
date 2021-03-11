import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'ggmap_decoder.dart';
import 'ggpack_entry.dart';
import 'input_stream.dart';
import 'package:path/path.dart' as path;
import 'xor_decoder.dart';

class GGPackFileDecoder extends IterableBase<GGPackEntry> {
  Key key;
  InputStream _input;
  List<GGPackEntry> _entries;

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

  GGPackEntry operator [](int index) => _entries[index];

  @override
  Iterator<GGPackEntry> get iterator => _entries.iterator;

  List<int> extract(String name, [bool convert = true]) {
    final entry = _entries.firstWhere((element) => element.filename == name);
    if (entry == null) return null;
    final bytes = _input.data.buffer.asUint8List(entry.offset, entry.size);
    final decodedData = XorDecoder(key).convert(bytes);

    if (path.extension(name).toLowerCase() == '.wimpy' && convert) {
      final wimpy = GGMapDecoder().convert(decodedData);
      final jObject = JsonEncoder.withIndent('  ').convert(wimpy);
      return utf8.encode(jObject);
    }
    return decodedData;
  }
}
