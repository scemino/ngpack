library ngpack;

import 'dart:io';
import 'dart:typed_data';
import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:ngpack/ngpack.dart';

ArgParser createParser() {
  return ArgParser()
    ..addOption('list',
        abbr: 'l', help: 'List files in the pack matching the pattern.')
    ..addOption('extract',
        abbr: 'x',
        help:
            'Extract the files from the pack matching the pattern to the current working directory.');
}

void main(List<String> arguments) async {
  final parser = createParser();

  try {
    final argResults = parser.parse(arguments);
    if (argResults.rest.isEmpty || !await File(argResults.rest[0]).exists()) {
      print('Please specify a ggpack file');
      return;
    }

    final listPattern = argResults['list'];
    final extractPattern = argResults['extract'];
    final bytes = await File(argResults.rest[0]).readAsBytes();
    final file = GGPackFile(ByteData.sublistView(bytes));
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
