import 'dart:convert';
import 'dart:typed_data';

const _DELTA = 0x9e3779b9;

int _int(int i) {
  return i & 0xFFFFFFFF;
}

int _mx(int sum, int y, int z, int p, int e, Uint32List key) {
  return ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4)) ^
      ((sum ^ y) + (key[p & 3 ^ e] ^ z));
}

/// A [XXTeaCodec] encodes bytes to bytes encrypted with XXTea.
class XXTeaEncoder extends Converter<List<int>, List<int>> {
  final Uint32List key;

  XXTeaEncoder(List<int> key) : key = Uint32List.fromList(key);

  @override
  List<int> convert(List<int> bytes) {
    final v = Uint32List.view(Uint8List.fromList(bytes).buffer);
    final length = v.length;
    final n = length - 1;
    var y, z, sum, e, p, q;
    z = v[n];
    sum = 0;
    for (q = 6 + (52 ~/ length); q > 0; --q) {
      sum = _int(sum + _DELTA);
      e = sum >> 2 & 3;
      for (p = 0; p < n; ++p) {
        y = v[p + 1];
        z = v[p] = _int(v[p] + _mx(sum, y, z, p, e, key));
      }
      y = v[0];
      z = v[n] = _int(v[n] + _mx(sum, y, z, p, e, key));
    }
    return Uint8List.view(Uint32List.fromList(v).buffer);
  }
}

/// A [XXTeaDecoder] decodes XXTea encrypted bytes to bytes.
class XXTeaDecoder extends Converter<List<int>, List<int>> {
  final Uint32List key;

  XXTeaDecoder(List<int> key) : key = Uint32List.fromList(key);

  @override
  List<int> convert(List<int> bytes) {
    final v = Uint32List.view(Uint8List.fromList(bytes).buffer);
    final length = v.length;
    final n = length - 1;
    var y, z, sum, e, p, q;
    y = v[0];
    q = 6 + (52 ~/ length);
    for (sum = _int(q * _DELTA); sum != 0; sum = _int(sum - _DELTA)) {
      e = sum >> 2 & 3;
      for (p = n; p > 0; --p) {
        z = v[p - 1];
        y = v[p] = _int(v[p] - _mx(sum, y, z, p, e, key));
      }
      z = v[n];
      y = v[0] = _int(v[0] - _mx(sum, y, z, p, e, key));
    }
    return Uint8List.view(Uint32List.fromList(v).buffer);
  }
}

/// A [XXTeaCodec] encodes bytes to bytes encrypted with XXTea and decodes XXTea encrypted bytes to
/// bytes.
class XXTeaCodec extends Codec<List<int>, List<int>> {
  final List<int> key;

  /// Creates a XXTeaCodec from a [key].
  const XXTeaCodec(this.key);

  @override
  Converter<List<int>, List<int>> get decoder => XXTeaDecoder(key);

  @override
  Converter<List<int>, List<int>> get encoder => XXTeaEncoder(key);
}
