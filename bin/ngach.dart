library ngpack;

import 'package:universal_io/io.dart';
import 'package:args/command_runner.dart';
import 'package:ngpack/ngpack.dart';

class ToCommand extends Command {
  @override
  final name = 'to';
  @override
  final description = 'Convert specified achievement file to text.';

  ToCommand();

  @override
  void run() {
    final fileNames = argResults?.rest;
    if (fileNames == null || fileNames.isEmpty) return;
    final bytes = File(fileNames[0]).readAsBytesSync();
    final ach = achievement.decode(bytes);
    print(ach.content);
  }
}

class FromCommand extends Command {
  @override
  final name = 'from';
  @override
  final description = 'Convert specified text file to achievement.';

  FromCommand();

  @override
  void run() {
    final fileNames = argResults?.rest;
    if (fileNames == null || fileNames.isEmpty) return;
    final content = File(fileNames[0]).readAsStringSync();
    final data = achievement.encode(Achievement(content, DateTime.now()));
    stdout.add(data);
  }
}

void main(List<String> arguments) {
  CommandRunner('ngach',
      'A tool to convert Thimbleweed Park achievement file (save.dat) to text and text to achievement.')
    ..addCommand(ToCommand())
    ..addCommand(FromCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64); // Exit code 64 indicates a usage error.
    });
}
