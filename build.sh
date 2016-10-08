#!/bin/sh

library="*CURLIB"

system_with_exit() {
  system "$1"
  if [ $? -gt 0 ]; then
    exit $?
  fi
}

# Library
system_with_exit "CRTRPGMOD MODULE(*CURLIB/ICONV) SRCSTMF('iconv.srvpgm.rpgle') DBGVIEW(*SOURCE)"
system_with_exit "CRTSRVPGM SRVPGM(*CURLIB/ICONV) MODULE(*CURLIB/ICONV) SRCFILE(*CURLIB/QSRVSRC) TGTRLS(*CURRENT)"

system "DLTBNDDIR BNDDIR(*CURLIB/ICONV)"
system_with_exit "CRTBNDDIR BNDDIR(*CURLIB/ICONV)"
system_with_exit "ADDBNDDIRE BNDDIR(*CURLIB/ICONV) OBJ((ICONV *SRVPGM))"

# Test
system_with_exit "CRTBNDRPG PGM(*CURLIB/TSTICONV) SRCSTMF('example/tsticonv.rpgle') TGTRLS(*CURRENT) DBGVIEW(*SOURCE)"

echo "ICONV is built with success"
