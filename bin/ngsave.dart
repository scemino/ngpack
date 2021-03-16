library ngpack;

import 'dart:convert';
import 'package:universal_io/io.dart';
import 'package:args/command_runner.dart';
import 'package:ngpack/ngpack.dart';

class ToJsonCommand extends Command {
  @override
  final name = 'tojson';
  @override
  final description = 'Convert specified savegame file to json.';

  ToJsonCommand();

  @override
  void run() {
    final fileNames = argResults?.rest;
    if (fileNames == null || fileNames.isEmpty) return;
    final bytes = File(fileNames[0]).readAsBytesSync();
    final savedata = savegame.decode(bytes);
    print(JsonEncoder.withIndent('  ').convert(savedata.map));
  }
}

class FromJsonCommand extends Command {
  @override
  final name = 'fromjson';
  @override
  final description = 'Convert specified json file to savegame.';

  FromJsonCommand();

  @override
  void run() {
    final fileNames = argResults?.rest;
    if (fileNames == null || fileNames.isEmpty) return;
    final content = File(fileNames[0]).readAsStringSync();
    final savedata = TwpSavegame(json.decode(content), DateTime.now());
    stdout.add(savegame.encode(savedata));
  }
}

void main(List<String> arguments) {
  CommandRunner('ngsave',
      'A tool to convert Thimbleweed Park savegame to json and json to TWP savegame.')
    ..addCommand(ToJsonCommand())
    ..addCommand(FromJsonCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64); // Exit code 64 indicates a usage error.
    });
}
