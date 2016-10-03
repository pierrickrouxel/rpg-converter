**free
CTL-OPT BNDDIR('PR/ICONV');

/copy iconv.h.rpgle

DCL-S ebcdic CHAR(1) INZ(X'61');

DCL-S input POINTER INZ(*NULL);
DCL-S inputLength INT(10) INZ(0);
DCL-S output POINTER INZ(*NULL);
DCL-S outputLength INT(10) INZ(0);

DCL-S ascii CHAR(1) BASED(output);

DCL-S display CHAR(50) INZ('This value should be equal to ''a'': ');
DCL-S returnValue INT(10) INZ(0);

input = %ADDR(ebcdic);
inputLength = %LEN(%TRIMR(ebcdic));

outputLength = inputLength;
output = %ALLOC(outputLength);

input = %ADDR(ascii);

returnValue = ccsidConvert(input:
                           inputLength:
                           '00037':
                           output:
                           outputLength:
                           '00819');

IF returnValue > 0;
  DSPLY 'Erreur';
ENDIF;

display = display + ascii;
DSPLY display;

RETURN;
