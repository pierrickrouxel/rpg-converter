# rpg-converter

This project provides tools to do conversions in RPG.

# Building rpg-converter

Run `./build.sh` in the directory.

All objects are created in `*CURLIB`.

# Objects

* `CONVERTER` - the `*SRVPGM` containing all exported methods
* `TSTICONV` - the example `*PGM` to test iconv methods

# Methods

## ccsidConvert

Do conversions between charsets.

The function return -1 on error.

Parameters:

* input POINTER - the pointer on input string
* inputLength UNS(10) - the length of input string
* inputCcsid INT(10) - the CCSID of input string
* output POINTER - the pointer on output string
* outputLength UNS(10) - the length of output
* outputCcsid INT(10) - then CCSID of output string
 
CCSID examples:

* 1208 - UTF-8
* 819 - ASCII
* 0 - Job's CCSID
