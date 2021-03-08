import 'dart:typed_data';

class InputStream {
  ByteData data;
  int offset = 0;

  int get position => offset;

  InputStream(ByteData input) {
    data = input;
  }

  int readUint32() {
    final value = data.getUint32(offset, Endian.little);
    offset += 4;
    return value;
  }

  int readUint8() {
    return data.getUint8(offset++);
  }

  void seek(int pos) {
    offset = pos;
  }
}

