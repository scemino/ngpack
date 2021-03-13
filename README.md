# ngpack
A simple command-line application to list or extract files from ggpack files, used by the [Thimbleweed Park](https://thimbleweedpark.com) game, which is an awesome adventure game, go buy it right now, you won't regret it (Steam, GOG).

## Build & Run

* clone the project: git clone https://github.com/scemino/ngpack.git
* run: `dart run bin/ngpack.dart ThimbleweedPark.ggpack1 *.bnut`
* or  create the executable `dart compile exe bin/ngpack.dart`

That's it

## Usage
```
usage: ngpack --list|--extract "pattern" [--key key] file

-k, --key        Name of the key to decrypt/encrypt the data.
                 Possible names: 56ad (default), 5bad, 566d, 5b6d, delores
                 (defaults to "56ad")
-l, --list       List files in the pack matching the pattern.
-x, --extract    Extract the files from the pack matching the pattern to the current working directory.
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