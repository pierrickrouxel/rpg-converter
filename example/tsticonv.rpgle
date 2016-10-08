**free
CTL-OPT BNDDIR('PR/ICONV');

/copy iconv.h.rpgle

// X'61' is 'a' in ASCII
DCL-S ascii CHAR(1) INZ(X'61');
DCL-S display CHAR(50);

DCL-S input POINTER INZ(*NULL);
DCL-S inputLength UNS(10) INZ(0);
DCL-S outputLength UNS(10) INZ(0);

// Pointers
DCL-S pointerOutput POINTER INZ(*NULL);
DCL-S pointerEbcdic CHAR(1) BASED(pointerOutput);

// Variables
DCL-S variableEbcdic CHAR(1);

// EBCDIC-UTF can use 6 byte for a character
outputLength = %LEN(%TRIMR(ascii)) * 6;


//----------
// Test with pointers
//----------

pointerOutput = %ALLOC(outputLength);

IF ccsidConvert(%ADDR(ascii):
                %LEN(%TRIMR(ascii)):
                819:
                pointerOutput:
                outputLength:
                0) > 0;
  DSPLY 'Erreur';
ENDIF;

DSPLY 'Test with pointers';
display = 'expected pointer value ''a'', got ''' + pointerEbcdic + '''';
DSPLY display;

DEALLOC(N) pointerOutput;


//----------
// Test with variables
//----------

IF ccsidConvert(%ADDR(ascii):
                %LEN(%TRIMR(ascii)):
                819:
                %ADDR(variableEbcdic):
                outputLength:
                0) > 0;
  DSPLY 'Erreur';
ENDIF;

DSPLY 'Test with variables';
display = 'expected pointer value ''a'', got ''' + variableEbcdic + '''';
DSPLY display;

RETURN;
