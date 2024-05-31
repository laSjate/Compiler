#ifndef SKENER_H
#define SKENER_H

#include "parser.h"


void yyerror(const char* s);
int yyparse(void);
int yylex();

#endif
