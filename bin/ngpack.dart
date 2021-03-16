library ngpack;

import 'package:universal_io/io.dart';
import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:glob/list_local_fs.dart';
import 'package:ngpack/ngpack.dart';

ArgParser createParser() {
  return ArgParser()
    ..addOption('key',
        abbr: 'k',
        help:
            'Name of the key to decrypt/encrypt the data.\nPossible names: auto (default), 56ad, 5bad, 566d, 5b6d, delores',
        defaultsTo: 'auto')
    ..addOption('list',
        abbr: 'l', help: 'List files in the ggpack matching the pattern.')
    ..addOption('extract',
        abbr: 'x',
        help:
            'Extract the files from the ggpack matching the pattern to the current working directory.')
    ..addOption('create',
        abbr: 'c',
        help: 'Create a ggpack from the files matching the pattern.');
}

void usage(ArgParser parser) {
  print('usage: ngpack --list|--extract|--create "pattern" [--key key] file');
  print('');
  print(parser.usage);
}

bool checkInputFile(ArgParser parser, ArgResults argResults) {
  if (argResults.rest.isEmpty || !File(argResults.rest[0]).existsSync()) {
    print('Please specify a ggpack file');
    print('');
    usage(parser);
    return false;
  }
  return true;
}

void main(List<String> arguments) async {
  final parser = createParser();

  try {
    final argResults = parser.parse(arguments);
    final key =
        argResults['key'] == 'auto' ? null : knownXorKeys[argResults['key']];
    final listPattern = argResults['list'];
    final extractPattern = argResults['extract'];
    final createPattern = argResults['create'];

    if (listPattern != null) {
      if (!checkInputFile(parser, argResults)) return;
      final file = GGPackDecoder.fromFile(argResults.rest[0], xorKey: key);
      file.where((e) => Glob(listPattern).matches(e.filename)).forEach(print);
    } else if (extractPattern != null) {
      if (!checkInputFile(parser, argResults)) return;
      final file = GGPackDecoder.fromFile(argResults.rest[0], xorKey: key);
      file.where((e) => Glob(extractPattern).matches(e.filename)).forEach((e) {
        final data = file.extract(e.filename);
        File(e.filename).writeAsBytes(data);
      });
    } else if (createPattern != null) {
      var builder =
          GGPackBuilder(key ?? knownXorKeys.fromId(KnownXorKeyId.Key56ad));
      await Glob(createPattern).list().where((e) => e is File).forEach((e) {
        final entry = path.basename(e.path);
        print('add entry $entry from ${e.path}');
        builder.addFile(entry, e.path);
      });
      await File(argResults.rest[0]).writeAsBytes(builder.build());
      print('${argResults.rest[0]} created.');
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    usage(parser);
  }
}
