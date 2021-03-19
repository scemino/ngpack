library ngpack;

import 'package:args/command_runner.dart';
import 'package:universal_io/io.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:glob/list_local_fs.dart';
import 'package:ngpack/ngpack.dart';

abstract class KeyCommand extends Command {
  XorKey? key;
  String? pattern;
  String? filename;

  bool get checkInputExists => true;

  KeyCommand({String keyDefaultTo = 'auto'}) {
    argParser.addOption('key',
        help: 'Name of the key to decrypt/encrypt the data.\n'
            'Possible names: auto, 56ad, 5bad, 566d, 5b6d, delores\n',
        defaultsTo: keyDefaultTo,
        abbr: 'k');

    argParser.addOption('pattern',
        help: 'Pattern to use to match entries.', defaultsTo: '*', abbr: 'p');
  }

  @override
  void run() {
    key =
        argResults!['key'] == 'auto' ? null : knownXorKeys[argResults!['key']];
    pattern = argResults!['pattern'];

    if (argResults!.rest.isEmpty ||
        (checkInputExists && !File(argResults!.rest[0]).existsSync())) {
      throw UsageException('Please specify a ggpack file', usage);
    }

    filename = argResults!.rest[0];
  }
}

class ListCommand extends KeyCommand {
  @override
  final name = 'list';
  @override
  final description = 'List files in the ggpack matching the pattern.';

  ListCommand();

  @override
  void run() {
    super.run();
    final file = GGPackDecoder.fromFile(filename!, xorKey: key);
    file.where((e) => Glob(pattern!).matches(e.filename)).forEach(print);
  }
}

class ExtractCommand extends KeyCommand {
  @override
  final name = 'extract';
  @override
  final description =
      'Extract the files from the ggpack matching the pattern to the current working directory.';

  ExtractCommand();

  @override
  void run() {
    super.run();
    final file = GGPackDecoder.fromFile(filename!, xorKey: key);
    final entries =
        file.where((e) => Glob(pattern!).matches(e.filename)).toList();
    var i = 0;
    entries.forEach((e) {
      var progress = 100.0 * (++i) / entries.length;
      final data = file.extract(e.filename);
      var outFile = File(e.filename);
      outFile.writeAsBytesSync(data);
      stdout.write(
          '\rExtracting ${e.filename.padRight(48)} ${progress.toStringAsFixed(1).padLeft(5)}%');
    });
    print('\r${entries.length} file(s) extracted'.padRight(72));
  }
}

class CreateCommand extends KeyCommand {
  @override
  final name = 'create';
  @override
  final description = 'Create a ggpack from the files matching the pattern.';
  @override
  final bool checkInputExists = false;

  CreateCommand() : super(keyDefaultTo: '56ad');

  @override
  void run() {
    super.run();
    var builder =
        GGPackBuilder(key ?? knownXorKeys.fromId(KnownXorKeyId.Key56ad));
    Glob(pattern!).list().where((e) => e is File).forEach((e) {
      final entry = path.basename(e.path);
      print('add entry $entry from ${e.path}');
      builder.addFile(entry, e.path);
    });
    File(filename!).writeAsBytesSync(builder.build());
    print('${filename!} created.');
  }
}

void main(List<String> arguments) {
  CommandRunner(
      'ngpack', 'A tool to list/extract/create Thimbleweed Park ggpack file.')
    ..addCommand(ListCommand())
    ..addCommand(ExtractCommand())
    ..addCommand(CreateCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64); // Exit code 64 indicates a usage error.
    });
}
