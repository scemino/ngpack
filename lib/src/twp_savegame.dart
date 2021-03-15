import 'dart:convert';
import 'dart:typed_data';
import 'package:ngpack/ngpack.dart';
import 'package:ngpack/src/xxtea_encoder.dart';

class TwpSavegame {
  Map<String, dynamic> map;
  DateTime time;

  TwpSavegame(this.map, this.time);
}

const _TwpSavegamekey = [0xAEA4EDF3, 0xAFF8332A, 0xB5A2DBB4, 0x9B4BA022];

int _computeChecksum(Uint8List data) {
  return data.fold(0x6583463, (previous, current) => previous + current);
}

const savegame = TwpSaveGameCodec();

class TwpSaveGameCodec extends Codec<TwpSavegame, List<int>> {
  /// Creates a [TwpSaveGameCodec].
  const TwpSaveGameCodec();

  @override
  Converter<List<int>, TwpSavegame> get decoder => TwpSaveGameDecoder();

  @override
  Converter<TwpSavegame, List<int>> get encoder => TwpSaveGameEncoder();
}

class TwpSaveGameDecoder extends Converter<List<int>, TwpSavegame> {
  const TwpSaveGameDecoder();

  @override
  TwpSavegame convert(List<int> bytes) {
    final decoded = XXTeaCodec(_TwpSavegamekey).decode(bytes);
    final data = ByteData.view(Uint8List.fromList(decoded).buffer);
    final footerLength = _getFooterLength(data);
    final checksum =
        data.getUint32(data.lengthInBytes - footerLength, Endian.little);
    final saveDateTime =
        data.getUint32(data.lengthInBytes - footerLength + 4, Endian.little);
    var computedChecksum = _computeChecksum(
        Uint8List.view(data.buffer, 0, data.lengthInBytes - footerLength));
    final date =
        DateTime.fromMillisecondsSinceEpoch(saveDateTime * 1000, isUtc: true);

    if (checksum != computedChecksum) {
      throw ArgumentError.value(
          bytes, 'bytes', 'Invalid checksum, is it a TWP savegame ?');
    }
    final map = ggmap.decode(Uint8List.fromList(decoded));
    return TwpSavegame(map, date);
  }

  int _getFooterLength(ByteData data) {
    return 9 + data.getUint8(data.lengthInBytes - 1);
  }
}

class TwpSaveGameEncoder extends Converter<TwpSavegame, List<int>> {
  @override
  List<int> convert(TwpSavegame savegame) {
    final mapBytes = ggmap.encode(savegame.map);
    final marker = _createMarker(mapBytes);
    final checksum = _computeChecksum(Uint8List.fromList(mapBytes));
    final saveDateTime = savegame.time.millisecondsSinceEpoch ~/ 1000;
    var footer = ByteData.view(Uint32List(2).buffer);
    footer.setUint32(0, checksum, Endian.little);
    footer.setUint32(4, saveDateTime, Endian.little);
    final data = BytesBuilder();
    data.add(mapBytes);
    data.add(footer.buffer.asUint8List(0));
    data.add(marker);
    return XXTeaCodec(_TwpSavegamekey).encode(data.toBytes());
  }

  static Uint8List _createMarker(Uint8List mapBytes) {
    final markerByte = 8 - ((mapBytes.lengthInBytes + 9) % 8);
    final markerLength = 9 - markerByte;
    return Uint8List.fromList(List<int>.filled(markerLength, markerByte));
  }

  static int _computeChecksum(Uint8List data) {
    return data.fold(0x6583463, (previous, current) => previous + current);
  }
}
