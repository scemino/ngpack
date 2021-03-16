import 'dart:convert';
import 'dart:typed_data';
import 'checksum_decoder.dart';

class DataChecksum {
  final Uint8List data;
  final int checksum;
  final DateTime dateTime;

  const DataChecksum(this.data, this.checksum, this.dateTime);
}

const dataChecksum = DataChecksumCodec();

class DataChecksumCodec extends Codec<DataChecksum, List<int>> {
  /// Creates an [DataChecksumCodec].
  const DataChecksumCodec();

  @override
  Converter<List<int>, DataChecksum> get decoder => DataChecksumDecoder();

  @override
  Converter<DataChecksum, List<int>> get encoder => DataChecksumEncoder();
}

class DataChecksumEncoder extends Converter<DataChecksum, Uint8List> {
  @override
  Uint8List convert(DataChecksum data) {
    return withChecksumAndDateTime(data.data, data.checksum, data.dateTime);
  }

  static Uint8List withChecksumAndDateTime(
      Uint8List bytes, int checksum, DateTime dateTime) {
    // create footer
    var footer = ByteData.view(Uint32List(2).buffer);
    footer.setUint32(0, checksum, Endian.little);
    footer.setUint32(4, dateTime.millisecondsSinceEpoch ~/ 1000, Endian.little);
    final marker = _createMarker(bytes);

    // append footer and marker to data
    final data = BytesBuilder();
    data.add(bytes);
    data.add(footer.buffer.asUint8List(0));
    data.add(marker);
    return data.toBytes();
  }

  static Uint8List _createMarker(Uint8List bytes) {
    final markerByte = 8 - ((bytes.lengthInBytes + 9) % 8);
    final markerLength = markerByte + 1;
    return Uint8List.fromList(List<int>.filled(markerLength, markerByte));
  }
}

class DataChecksumDecoder extends Converter<Uint8List, DataChecksum> {
  @override
  DataChecksum convert(Uint8List bytes) {
    final data = ByteData.view(Uint8List.fromList(bytes).buffer);
    final footerLength = _getFooterLength(data);
    final checksum =
        data.getUint32(data.lengthInBytes - footerLength, Endian.little);
    var computedChecksum = ChecksumDecoder().convert(
        Uint8List.view(data.buffer, 0, data.lengthInBytes - footerLength));

    // check checksum
    if (checksum != computedChecksum) {
      throw ArgumentError.value(bytes, 'bytes', 'Invalid checksum');
    }

    final saveDateTime =
        data.getUint32(data.lengthInBytes - footerLength + 4, Endian.little);
    final date =
        DateTime.fromMillisecondsSinceEpoch(saveDateTime * 1000, isUtc: true);
    return DataChecksum(
        Uint8List.view(data.buffer, 0, data.lengthInBytes - footerLength),
        checksum,
        date);
  }

  int _getFooterLength(ByteData data) {
    return 9 + data.getUint8(data.lengthInBytes - 1);
  }
}
