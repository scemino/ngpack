import 'dart:typed_data';

class OutputStream {
  static const _BLOCK_SIZE = 0x8000; // 32k

  Uint8List _data;
  int _length = 0;
  int _offset = 0;

  int get position => _offset;
  set position(int pos) {
    _offset = pos;
    if (_offset > length) {
      throw Exception('Seeking past output stream is not supported.');
    }
  }

  int get length => _length;

  OutputStream() {
    _data = Uint8List(_BLOCK_SIZE);
  }

  void writeInt32(int value) {
    writeUint8((value) & 0xff);
    writeUint8((value >> 8) & 0xff);
    writeUint8((value >> 16) & 0xff);
    writeUint8((value >> 24) & 0xff);
  }

  void writeBytes(Uint8List bytes) {
    bytes.forEach(writeUint8);
  }

  void writeUint8(int value) {
    if (_offset == _data.length) {
      _expandBuffer();
    }
    _data[_offset++] = value & 0xff;
    if (_offset > _length) _length = _offset;
  }

  void _expandBuffer([int len]) {
    var blockSize = _BLOCK_SIZE;
    if (len != null) {
      if (len > blockSize) {
        blockSize = len;
      }
    }
    final newLength = (_data.length + blockSize) * 2;
    final newBuffer = Uint8List(newLength);
    newBuffer.setRange(0, _data.length, _data);
    _data = newBuffer;
  }

  Uint8List toBytes() {
    return _data.buffer.asUint8List(0, length);
  }
}
