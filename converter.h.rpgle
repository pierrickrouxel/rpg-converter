**free

//*
// Do conversions between charsets.
// @param input Input string
// @param inputLength Input string length
// @param inputCcsid Input CCSID (0 for job CCSID)
// @param output Output string
// @param outputLength Output string length
// @param outputCcsid Output CCSID (0 for job CCSID)
// @return -1 on error
DCL-PR ccsidConvert INT(10);
  input POINTER CONST;
  inputLength UNS(10) CONST;
  inputCcsid INT(10) CONST;
  output POINTER CONST;
  outputLength UNS(10);
  outputCcsid INT(10) CONST;
END-PR;

//*
// Returns string in upper case.
// @param string Input string
// @return String in lower case
DCL-PR toUpperCase CHAR(16773104);
  string CHAR(16773104) CONST;
END-PR;

//*
// Returns string in lower case.
// @param string Input string
// @return String in upper case
DCL-PR toLowerCase CHAR(16773104);
  string CHAR(16773104) CONST;
END-PR;
