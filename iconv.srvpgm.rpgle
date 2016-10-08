**free
CTL-OPT NOMAIN
        BNDDIR('QC2LE');

DCL-DS conversionDescriptor QUALIFIED;
  returnValue INT(10) INZ(0);
  cd INT(10) DIM(12) INZ(0);
END-DS;

DCL-DS conversionCode QUALIFIED;
  ccsid INT(10) INZ(0);
  conversionAlternative INT(10) INZ(0);
  substitutionAlternative INT(10) INZ(0);
  shiftStateAlternative INT(10) INZ(1);
  inputLengthOption INT(10) INZ(0);
  mixedErrorOption INT(10) INZ(1);
  reserved CHAR(8) INZ(*ALLX'00');
END-DS;

DCL-PR iconvOpen LIKEDS(conversionDescriptor) EXTPROC('QtqIconvOpen');
  to LIKEDS(conversionCode) CONST;
  from LIKEDS(conversionCode) CONST;
END-PR;

DCL-PR iconv UNS(10) EXTPROC('iconv');
  conversionDescriptor LIKEDS(conversionDescriptor) VALUE;
  input POINTER;
  inputLength UNS(10);
  output POINTER;
  outputLength UNS(10);
END-PR;

DCL-PR iconvClose EXTPROC('iconv_close');
  conversionDescriptor LIKEDS(conversionDescriptor) VALUE;
END-PR;

DCL-DS descriptor LIKEDS(conversionDescriptor) INZ(*LIKEDS);
DCL-DS from LIKEDS(conversionCode) INZ(*LIKEDS);
DCL-DS to LIKEDS(conversionCode) INZ(*LIKEDS);

DCL-PROC ccsidConvert EXPORT;
  DCL-PI *N INT(10);
    input POINTER;
    inputLength UNS(10);
    inputCcsid INT(10);
    output POINTER;
    outputLength UNS(10);
    outputCcsid INT(10);
  END-PI;
  
  // The iconv API will change the pointer address
  DCL-S outputCopy POINTER;
  outputCopy = output;

  // Configure conversion
  from.ccsid = inputCcsid;
  to.ccsid = outputCcsid;

  descriptor = iconvOpen(to:from);
  IF descriptor.returnValue = -1;
    RETURN 1;
  ENDIF;

  IF iconv(descriptor:
        input:inputLength:
        outputCopy:outputLength) = -1;
    RETURN 1;
  ENDIF;

  iconvClose(descriptor);
  IF descriptor.returnValue = -1;
    RETURN 1;
  ENDIF;

  RETURN 0;
END-PROC;
