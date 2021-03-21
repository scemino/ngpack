# ngpack
A simple command-line application to list or extract files from ggpack files, used by the [Thimbleweed Park](https://thimbleweedpark.com) game, which is an awesome adventure game, go buy it right now, you won't regret it (Steam, GOG).

## Build & Run

* clone the project: git clone https://github.com/scemino/ngpack.git
* run: `dart run bin/ngpack.dart list -p "*.bnut" ThimbleweedPark.ggpack1`
* or  create the executable `dart compile exe bin/ngpack.dart`

That's it

## Usage
```
A tool to list/extract/create Thimbleweed Park ggpack file.

Usage: ngpack <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  create    Create a ggpack from the files matching the pattern.
  extract   Extract the files from the ggpack matching the pattern to the current working directory.
  list      List files in the ggpack matching the pattern.

Run "ngpack help <command>" for more information about a command.
```

```
A tool to convert Thimbleweed Park savegame to json and json to TWP savegame.

Usage: ngsave <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  fromjson   Convert specified json file to savegame.
  tojson     Convert specified savegame file to json.

Run "ngsave help <command>" for more information about a command.
```

```
A tool to convert Thimbleweed Park achievement file (save.dat) to text and text to achievement.

Usage: ngach <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  from   Convert specified text file to achievement.
  to     Convert specified achievement file to text.

Run "ngach help <command>" for more information about a command.
```

## Thanks
This project has been adapted from the awesome projects https://github.com/mrmacete/r2-ggpack and twp-ggdump https://github.com/mstr-/twp-ggdump

## Features
* Browse all files into the ggpack
* Search files with globbing
* Extract files from the ggpack
* Convert wimpy files to json
* Convert json files to wimpy files
* Convert bnut files to nut files
* Convert nut files to bnut files
* Create a pack
* Auto-detect xor key used to decode ggpack files
* Convert TWP savegame to json
* Convert json to TWP savegame
* Read/write TWP achievements
