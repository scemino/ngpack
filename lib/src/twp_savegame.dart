import 'dart:convert';
import 'dart:typed_data';
import 'checksum_decoder.dart';
import 'data_checksum_encoder.dart';
import 'ggmap_codec.dart';
import 'xxtea_encoder.dart';

class TwpSavegame {
  Map<String, dynamic> map;
  DateTime time;

  TwpSavegame(this.map, this.time);
}

const _TwpSavegamekey = [0xAEA4EDF3, 0xAFF8332A, 0xB5A2DBB4, 0x9B4BA022];

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
    final data = dataChecksum.decode(decoded);
    return TwpSavegame(ggmap.decode(data.data), data.dateTime);
  }
}

class TwpSaveGameEncoder extends Converter<TwpSavegame, List<int>> {
  @override
  List<int> convert(TwpSavegame savegame) {
    final bytes = ggmap.encode(savegame.map);
    final data = DataChecksum(Uint8List.fromList(bytes),
        ChecksumDecoder().convert(bytes), savegame.time);
    return XXTeaCodec(_TwpSavegamekey).encode(dataChecksum.encode(data));
  }
}
