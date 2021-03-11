const Signature = 0x04030201;

class Markers {
  static const int Null = 1;
  static const int Dictionary = 2;
  static const int Array = 3;
  static const int String = 4;
  static const int Integer = 5;
  static const int Double = 6;
  static const int Offsets = 7;
  static const int Keys = 8;
  static const int EndOffsets = 0xFFFFFFFF;
}
