import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ngpack/ngpack.dart';
import 'package:test/test.dart';

void main() {
  test('xorEncode', () {
    final data = 'hello world';
    final bytes = Uint8List.fromList(data.codeUnits);
    final actual = XorEncoder(Keys[KnownKey.Key5b6d]!).convert(bytes).toList();
    final expected = [44, 187, 16, 237, 151, 51, 9, 79, 216, 227, 44];
    expect(actual, equals(expected));
  });
  test('xorDecode', () {
    final data =
        Uint8List.fromList([44, 187, 16, 237, 151, 51, 9, 79, 216, 227, 44]);
    final actual =
        utf8.decode(XorDecoder(Keys[KnownKey.Key5b6d]!).convert(data));
    expect(actual, equals('hello world'));
  });
  test('mapEncode', () {
    final data = {
      'integer': 5,
      'array': [
        null,
        0,
        true,
        3.14,
        'string',
        {'key': 'value'}
      ]
    };
    final actual = GGMapEncoder().convert(data).toList();
    final expected = File('test/mapEncoded').readAsBytesSync().toList();
    expect(actual, equals(expected));
  });
  test('mapDecode', () {
    final data = File('test/mapEncoded').readAsBytesSync();
    final actual = GGMapDecoder().convert(data);
    final expected = {
      'integer': 5,
      'array': [
        null,
        0,
        1,
        3.14,
        'string',
        {'key': 'value'}
      ]
    };
    expect(actual, equals(expected));
  });
  test('ggpackEncode', () {
    final encoder = GGPackFileEncoder(Keys[KnownKey.Key56ad]!)
      ..addFile('hello.txt', Uint8List.fromList('hello world'.codeUnits))
      ..close();
    final actual = encoder.toBytes();
    final expected = File('test/ggpackEncoded.ggpack').readAsBytesSync();
    expect(actual, equals(expected));
  });
  test('ggpackDecode', () {
    final data = File('test/ggpackEncoded.ggpack').readAsBytesSync();
    final decoder = GGPackFileDecoder(data, Keys[KnownKey.Key56ad]!);
    final entries = decoder.toList();
    expect(entries, containsAllInOrder([GGPackEntry('hello.txt', 8, 11)]));
    final content = utf8.decode(decoder.extract('hello.txt'));
    expect(content, equals('hello world'));
  });
}
