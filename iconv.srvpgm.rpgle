**free
CTL-OPT NOMAIN;

DCL-DS fromCode QUALIFIED;
  wordIbmccsid CHAR(8) INZ('IBMCCSID');
  ccsid CHAR(5) INZ('00000');
  conversionAlternative CHAR(3) INZ('000');
  substitutionAlternative CHAR(1) INZ('0');
  shiftStateAlternative CHAR(1) INZ('0');
  inputLengthOption CHAR(1) INZ('0');
  mixedErrorOption CHAR(1) INZ('0');
  reserved CHAR(12) INZ(*ALLX'00');
END-DS;

DCL-DS toCode QUALIFIED;
  wordIbmccsid CHAR(8) INZ('IBMCCSID');
  ccsid CHAR(5) INZ('00000');
  reserved CHAR(19) INZ(*ALLX'00');
END-DS;

DCL-DS conversionDescriptor QUALIFIED;
  returnValue INT(10) INZ(0);
  cd INT(10) DIM(12) INZ(0);
END-DS;

DCL-PR iconvOpen LIKEDS(conversionDescriptor) EXTPROC('iconv_open');
  toCode LIKEDS(toCode);
  fromCode LIKEDS(fromCode);
END-PR;

DCL-PR iconv UNS(10) EXTPROC('iconv');
  conversionDescriptor LIKEDS(conversionDescriptor) VALUE;
  input POINTER VALUE;
  inputLength INT(10);
  output POINTER;
  outputLength INT(10);
END-PR;

DCL-PR iconvClose EXTPROC('iconv_close');
  conversionDescriptor LIKEDS(conversionDescriptor) VALUE;
END-PR;

DCL-S returnCode UNS(10) INZ(0);
DCL-S error INT(10) INZ(0);

DCL-C errorCode 4294967295;

DCL-PROC ccsidConvert EXPORT;
  DCL-PI *N INT(10);
    input POINTER;
    inputLength INT(10);
    inputCcsid CHAR(5) CONST;
    output POINTER;
    outputLength INT(10);
    outputCcsid CHAR(5) CONST;
  END-PI;

  // Clean parameters
  CLEAR conversionDescriptor;
  CLEAR fromCode;
  CLEAR toCode;

  // Configure conversion
  fromCode.ccsid = inputCcsid;
  toCode.ccsid = outputCcsid;

  conversionDescriptor = iconvOpen(toCode:fromCode);

  returnCode = iconv(conversionDescriptor:
        input:inputLength:
        output:outputLength);

  iconvClose(conversionDescriptor);

  IF returnCode = errorCode;
    RETURN 1;
  ENDIF;

  RETURN 0;
END-PROC;
