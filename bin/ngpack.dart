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
            'Name of the key to decrypt/encrypt the data.\nPossible names: auto (default), 56ad, 5bad, 566d, 5b6d, delores',
        defaultsTo: 'auto')
    ..addOption('list',
        abbr: 'l', help: 'List files in the pack matching the pattern.')
    ..addOption('extract',
        abbr: 'x',
        help:
            'Extract the files from the pack matching the pattern to the current working directory.');
}

void usage(ArgParser parser) {
  print('usage: ngpack --list|--extract "pattern" [--key key] file');
  print('');
  print(parser.usage);
}

void main(List<String> arguments) async {
  final parser = createParser();

  try {
    final argResults = parser.parse(arguments);
    if (argResults.rest.isEmpty || !await File(argResults.rest[0]).exists()) {
      print('Please specify a ggpack file');
      print('');
      usage(parser);
      return;
    }

    final bytes = await File(argResults.rest[0]).readAsBytes();
    final key =
        argResults['key'] == 'auto' ? null : knownXorKeys[argResults['key']];
    final listPattern = argResults['list'];
    final extractPattern = argResults['extract'];
    final file = GGPackDecoder(bytes, xorKey: key);
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
    usage(parser);
  }
}
