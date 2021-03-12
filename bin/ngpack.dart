library ngpack;

import 'dart:io';
import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:ngpack/ngpack.dart';

ArgParser createParser() {
  return ArgParser()
    ..addOption('key',
        abbr: 'k',
        help:
            'Name of the key to decrypt/encrypt the data.\nPossible names: 56ad (default), 5bad, 566d, 5b6d',
        defaultsTo: '56ad')
    ..addOption('list',
        abbr: 'l', help: 'List files in the pack matching the pattern.')
    ..addOption('extract',
        abbr: 'x',
        help:
            'Extract the files from the pack matching the pattern to the current working directory.');
}

KnownKey parseKey(String? key) {
  switch (key) {
    case '56ad':
      return KnownKey.Key56ad;
    case '5bad':
      return KnownKey.Key5bad;
    case '566d':
      return KnownKey.Key566d;
    case '5b6d':
      return KnownKey.Key5b6d;
    default:
      throw FormatException('Invalid key, please specify one of the valid keys.');
  }
}

void main(List<String> arguments) async {
  final parser = createParser();

  try {
    final argResults = parser.parse(arguments);
    if (argResults.rest.isEmpty || !await File(argResults.rest[0]).exists()) {
      print('Please specify a ggpack file');
      return;
    }

    final key = parseKey(argResults['key']);
    final listPattern = argResults['list'];
    final extractPattern = argResults['extract'];
    final bytes = await File(argResults.rest[0]).readAsBytes();
    final file = GGPackFileDecoder(bytes, Keys[key]!);
    if (listPattern != null) {
      file.where((e) => Glob(listPattern).matches(e.filename)).forEach(print);
    } else if (extractPattern != null) {
      file.where((e) => Glob(extractPattern).matches(e.filename)).forEach((e) {
        final data = file.extract(e.filename);
        File(e.filename).writeAsBytes(data);
      });
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    print('usage: ngpack --list|--extract "pattern" file');
    print('');
    print(parser.usage);
  }
}
