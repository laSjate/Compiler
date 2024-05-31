#ifndef SKENER_H
#define SKENER_H

#include <stdio.h>
#include "parser.h"

int yylex(void);
void yyerror(const char* s);

#endif
