#!/bin/sh

library="*CURLIB"

system_with_exit() {
  system "$1"
  if [ $? -gt 0 ]; then
    exit $?
  fi
}

# Library
system "CRTSRCPF FILE(*CURLIB/QSRVSRC)"
system "ADDPFM FILE(*CURLIB/QSRVSRC) MBR(CONVERTER) SRCTYPE(BND)"
cat converter.bnd | Rfile -wQ "QSRVSRC(CONVERTER)"
system_with_exit "CRTRPGMOD MODULE(*CURLIB/CONVERTER) SRCSTMF('converter.srvpgm.rpgle') DBGVIEW(*SOURCE)"
system_with_exit "CRTSRVPGM SRVPGM(*CURLIB/CONVERTER) MODULE(*CURLIB/CONVERTER) SRCFILE(*CURLIB/QSRVSRC) TGTRLS(*CURRENT)"

system "DLTBNDDIR BNDDIR(*CURLIB/CONVERTER)"
system_with_exit "CRTBNDDIR BNDDIR(*CURLIB/CONVERTER)"
system_with_exit "ADDBNDDIRE BNDDIR(*CURLIB/CONVERTER) OBJ((CONVERTER *SRVPGM))"

# Test
system_with_exit "CRTBNDRPG PGM(*CURLIB/TSTICONV) SRCSTMF('example/tsticonv.rpgle') TGTRLS(*CURRENT) DBGVIEW(*SOURCE)"

echo "CONVERTER is built with success"
