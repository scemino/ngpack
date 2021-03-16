import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ngpack/ngpack.dart';
import 'package:ngpack/src/twp_achievement.dart';
import 'package:ngpack/src/xxtea_encoder.dart';
import 'package:test/test.dart';

void main() {
  test('xorEncode', () {
    final data = 'hello world';
    final bytes = Uint8List.fromList(data.codeUnits);
    final actual = XorCodec.fromId(KnownXorKeyId.Key5b6d).encode(bytes);
    final expected = [44, 187, 16, 237, 151, 51, 9, 79, 216, 227, 44];
    expect(actual, containsAllInOrder(expected));
  });
  test('xorDecode', () {
    final data =
        Uint8List.fromList([44, 187, 16, 237, 151, 51, 9, 79, 216, 227, 44]);
    final actual =
        utf8.decode(XorCodec.fromId(KnownXorKeyId.Key5b6d).decode(data));
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
    final actual = ggmap.encode(data);
    final expected = File('test/data/mapEncoded').readAsBytesSync();
    expect(actual, containsAllInOrder(expected));
  });
  test('mapDecode', () {
    final data = File('test/data/mapEncoded').readAsBytesSync();
    final actual = GGMapCodec().decode(data);
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
    final actual = GGPackBuilder(knownXorKeys.fromId(KnownXorKeyId.Key56ad))
        .addContent('hello.txt', 'hello world')
        .build();
    final expected = File('test/data/ggpackEncoded.ggpack').readAsBytesSync();
    expect(actual, equals(expected));
  });
  test('ggpackDecode', () {
    final decoder = GGPackDecoder.fromFile('test/data/ggpackEncoded.ggpack',
        xorKey: knownXorKeys.fromId(KnownXorKeyId.Key56ad));
    expect(decoder, containsAllInOrder([GGPackEntry('hello.txt', 8, 11)]));
    final content = utf8.decode(decoder.extract('hello.txt'));
    expect(content, equals('hello world'));
  });
  test('bnutDecode', () {
    final data = [0x63, 0xca, 0x67, 0x6f, 0x23, 0x4e];
    final decoded = bnut.decode(data);
    expect(decoded, equals('secret'));
  });
  test('xxteaEncode', () {
    const key = [0xAEA4EDF3, 0xAFF8332A, 0xB5A2DBB4, 0x9B4BA022];
    const expected = [
      0x54,
      0xC3,
      0xFB,
      0xB8,
      0xF5,
      0xAA,
      0x3F,
      0x3C,
      0x5B,
      0x91,
      0xC3,
      0x98
    ];
    final data = XXTeaCodec(key).encode('hello, world'.codeUnits);
    expect(data, equals(expected));
  });
  test('xxteaDecode', () {
    const key = [0xAEA4EDF3, 0xAFF8332A, 0xB5A2DBB4, 0x9B4BA022];
    const data = [
      0x54,
      0xC3,
      0xFB,
      0xB8,
      0xF5,
      0xAA,
      0x3F,
      0x3C,
      0x5B,
      0x91,
      0xC3,
      0x98
    ];
    final actual = XXTeaCodec(key).decode(data);
    expect(actual, equals('hello, world'.codeUnits));
  });
  test('achievementDecode', () {
    final bytes = File('test/data/save.dat').readAsBytesSync();
    final expectedLines = LineSplitter()
        .convert(File('test/data/savedat.txt').readAsStringSync());
    final expectedDateTime = DateTime.parse('2021-03-15 12:37:50.000Z');
    final ach = achievement.decode(bytes);
    final actualLines = LineSplitter().convert(ach.content);
    expect(actualLines, containsAllInOrder(expectedLines));
    expect(ach.dateTime, equals(expectedDateTime));
  });
  test('achievementEncode', () {
    final content = File('test/data/savedat.txt').readAsStringSync();
    final dateTime = DateTime.parse('2021-03-15 12:37:50.000Z');
    final bytes =
        Uint8List.fromList(achievement.encode(Achievement(content, dateTime)));
    final expected = File('test/data/save.dat').readAsBytesSync();
    expect(bytes, equals(expected));
  });
}
