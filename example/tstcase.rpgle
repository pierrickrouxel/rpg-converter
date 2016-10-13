**free
CTL-OPT BNDDIR('CONVERTER');

/copy converter.h.rpgle

DSPLY ('expected ''TEST'', got ''' + toUpperCase('test') + '''');

DSPLY ('expected ''test'', got ''' + toLowerCase('TEST') + '''');
