**free
CTL-OPT NOMAIN;

DCL-DS errorCode QUALIFIED;
  bytesProvided INT(10) INZ(%SIZE(errorCode));
  bytesAvailable INT(10);
  exceptionId CHAR(7);
END-DS;

DCL-DS controlBlock QUALIFIED;
  type INT(10) INZ(1);
  ccsid INT(10) INZ(0);
  case INT(10);
  reserved CHAR(10) INZ(*LOVAL);
END-DS;

DCL-PR convertCase EXTPGM('QLGCNVCS');
  controlBlock LIKEDS(controlBlock);
  input CHAR(16773104);
  output CHAR(16773104);
  length INT(10);
  errorCode LIKEDS(errorCode);
END-PR;

DCL-PROC toUpperCase;
  DCL-PI *N CHAR(16773104);
    string CHAR(16773104) CONST;
  END-PI;

  DCL-S output CHAR(16773104);

  RESET controlBlock;
  controlBlock.case = 0;

  convertCase(controlBlock:string:output:%SIZE(output):errorCode);
END-PROC;

DCL-PROC toLowerCase;
  DCL-PI *N CHAR(16773104);
    string CHAR(16773104) CONST;
  END-PI;

  DCL-S output CHAR(16773104);

  RESET controlBlock;
  controlBlock.case = 1;

  convertCase(controlBlock:string:output:%SIZE(output):errorCode);
END-PROC;
