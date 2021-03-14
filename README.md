# ngpack
A simple command-line application to list or extract files from ggpack files, used by the [Thimbleweed Park](https://thimbleweedpark.com) game, which is an awesome adventure game, go buy it right now, you won't regret it (Steam, GOG).

## Build & Run

* clone the project: git clone https://github.com/scemino/ngpack.git
* run: `dart run bin/ngpack.dart -l "*.bnut" ThimbleweedPark.ggpack1`
* or  create the executable `dart compile exe bin/ngpack.dart`

That's it

## Usage
```
usage: ngpack --list|--extract|--create "pattern" [--key key] file

-k, --key        Name of the key to decrypt/encrypt the data.
                 Possible names: auto (default), 56ad, 5bad, 566d, 5b6d, delores
                 (defaults to "auto")
-l, --list       List files in the ggpack matching the pattern.
-x, --extract    Extract the files from the ggpack matching the pattern to the current working directory.
-c, --create     Create a ggpack from the files matching the pattern.
```
## Thanks
This project has been adapted from the awesome projects https://github.com/mrmacete/r2-ggpack and twp-ggdump https://github.com/mstr-/twp-ggdump

## Features
* Browse all files into the ggpack
* Search files with globbing
* Show the content of a file
* Extract files from the ggpack
* Dump wimpy files
* Deobfuscate bnut files
* Create a pack
* Auto-detect xor key used to decode ggpack files