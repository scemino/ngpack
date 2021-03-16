import 'dart:convert';

class ChecksumDecoder extends Converter<List<int>, int> {
  const ChecksumDecoder();

  @override
  int convert(List<int> input) {
    return input.fold(0x6583463, (previous, current) => previous + current);
  }
}
