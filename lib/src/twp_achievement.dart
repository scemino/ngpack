import 'dart:convert';
import 'dart:typed_data';
import 'package:ngpack/src/line_normalizer.dart';

import 'checksum_decoder.dart';
import 'data_checksum_encoder.dart';
import 'xxtea_encoder.dart';

const _AchievementKey = [0x2aab9d93, 0xaff8562a, 0xb5a2dbb4, 0x2b4ba322];

/// This is the achivement content of Thimbleweed Park game.
class Achievement {
  final String content;
  final DateTime dateTime;

  /// Creates an achievement.
  const Achievement(this.content, this.dateTime);

  @override
  String toString() => content;
}

const achievement = AchievementCodec();

class AchievementCodec extends Codec<Achievement, List<int>> {
  /// Creates an [AchievementCodec].
  const AchievementCodec();

  @override
  Converter<List<int>, Achievement> get decoder => AchievementDecoder();

  @override
  Converter<Achievement, List<int>> get encoder => AchievementEncoder();
}

class AchievementDecoder extends Converter<List<int>, Achievement> {
  const AchievementDecoder();

  @override
  Achievement convert(List<int> bytes) {
    final decoded = XXTeaCodec(_AchievementKey).decode(bytes);
    final data = dataChecksum.decode(decoded);
    return Achievement(utf8.decode(data.data), data.dateTime);
  }
}

class AchievementEncoder extends Converter<Achievement, List<int>> {
  @override
  List<int> convert(Achievement achievement) {
    final bytes = LineNormalizer().convert(achievement.content).codeUnits;
    final data = DataChecksum(Uint8List.fromList(bytes),
        ChecksumDecoder().convert(bytes), achievement.dateTime);
    return XXTeaCodec(_AchievementKey).encode(dataChecksum.encode(data));
  }
}
