import 'dart:convert';
import 'dart:typed_data';
import 'ggmap_decoder.dart';
import 'ggmap_encoder.dart';

/// An instance of the default implementation of the [GGMapCodec].
///
/// This instance provides a convenient access to the most common GGMap
/// use cases.
///
/// Examples:
/// ```dart
/// var encoded = json.encode({ 'hello': 'world' });
/// var decoded = json.decode(encoded);
/// ```
/// The top-level [ggmapEncode] and [ggmapDecode] functions may be used instead if
/// a local variable shadows the [ggmap] constant.
const GGMapCodec ggmap = GGMapCodec();

/// Converts [Map<String, dynamic>] to bytes.
Uint8List ggmapEncode(Map<String, dynamic> map) => ggmap.encode(map);

/// Converts bytes to [Map<String, dynamic>].
Map<String, dynamic> ggmapDecode(Uint8List data) => ggmap.decode(data);

/// A [GGMapCodec] encodes [Map<String, dynamic>] to bytes and decodes bytes to
/// Map<String, dynamic>] objects.
///
/// Examples:
/// ```dart
/// var encoded = ggmap.encode({ 'hello': 'world' });
/// var decoded = ggmap.decode(encoded);
/// ```
class GGMapCodec extends Codec<Map<String, dynamic>, Uint8List> {
  const GGMapCodec();

  @override
  Converter<Uint8List, Map<String, dynamic>> get decoder => GGMapDecoder();

  @override
  Converter<Map<String, dynamic>, Uint8List> get encoder => GGMapEncoder();
}
