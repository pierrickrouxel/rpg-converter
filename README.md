# rpg-converter

This project provides tools to do conversions in RPG.

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

## toUpperCase

Returns string in upper case.

Parameters:

* string (Max input length 16 773 104)

## toLowerCase

Returns string in lower case.

Parameters:

* string (Max input length 16 773 104)

# Building rpg-converter

Run `./build.sh` in the directory.

All objects are created in `*CURLIB`.
