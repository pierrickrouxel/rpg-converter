**free
CTL-OPT BNDDIR('PR/ICONV');

/copy iconv.h.rpgle

// X'61' is 'a' in ASCII
DCL-S ascii CHAR(1) INZ(X'61');

DCL-S input POINTER INZ(*NULL);
DCL-S inputLength UNS(10) INZ(0);
DCL-S output POINTER INZ(*NULL);
DCL-S outputLength UNS(10) INZ(0);

//DCL-S ebcdic CHAR(1) BASED(output);
DCL-S ebcdic CHAR(1);

DCL-S display CHAR(50) INZ('This value should be equal to ''a'': ');

input = %ADDR(ascii);
inputLength = %LEN(%TRIMR(ascii));

// EBCDIC-UTF can use 6 byte for a character
outputLength = inputLength; // * 6;
//output = %ALLOC(outputLength);
output = %ADDR(ebcdic);

IF ccsidConvert(input:
                inputLength:
                819:
                output:
                outputLength:
                0) > 0;
  DSPLY 'Erreur';
ENDIF;

display = %TRIMR(display) + ' ' + ebcdic;
DSPLY display;

RETURN;
