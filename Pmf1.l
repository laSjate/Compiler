%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "example.tab.h"

    void yyerror(const char*);
    void InvalidToken();
    /*int yylineno = 1;*/
    /*int yyleng;*/
    int count = 0;
    extern int yylex();
    extern int yyparse();
%}

linefeed    \n

%x LINE_COMMENT 
%x MULTILINE_COMMENT

%%

"true"|"false"                                      { yylval.int_value = strcmp(yytext, "true") == 0 ? 1 : 0; return T_BOOL; }
"IF"                                                { return T_IF; }
"ELSE"                                              { return T_ELSE; }
"FOR"                                               { return T_FOR; }
"WHILE"                                             { return T_WHILE; }
"BREAK"                                             { return T_BREAK; }
"RETURN"                                            { return T_RETURN; }
"CONTINUE"                                          { return T_CONTINUE; }
"READ"                                              { return T_READ; }
"WRITE"                                             { return T_WRITE; }
"SKIP"                                              { return T_SKIP; }
"FI"                                                { return T_FI; }
"DO"                                                { return T_DO; }
"END"                                               { return T_END; }
"IN"                                                { return T_IN; }
"LET"                                               { return T_LET; }
"THEN"                                              { return T_THEN; }
"VOID"                                              { return T_VOID; }
"INT"                                               { return T_INT; }
"DOUBLE"                                            { return T_DOUBLE; }
"FLOAT"                                             { return T_FLOAT; }
"CHAR"                                              { return T_CHAR; }
"BOOL"                                              { return T_BOOL; }
"STRING"                                            { return T_STRING; }
"UNION"                                             { return T_UNION; }
"STRUCT"                                            { return T_STRUCT; }
[a-zA-Z_][a-zA-Z0-9_]{0,30}                         { yylval.ident = strdup(yytext); return T_ID; }
(0x|0X)[0-9A-Fa-f]*                                 { yylval.int_value = strtol(yytext, NULL, 16); return T_HEX; }
[0-9]+                                              { yylval.int_value = atoi(yytext); return T_INT_CONST; }
([0-9]*\.[0-9]+|[0-9]+\.)([Ee][+-]?[0-9]+)?         { yylval.double_value = atof(yytext); return T_DOUBLE_CONST; }
\"[^\n"]+\"                                         { yylval.string = strdup(yytext); return T_STRING; }

[ \r\t]                                             { /* Ignore whitespaces */ }

"//"                                                { BEGIN(LINE_COMMENT); }
"/*"                                                { count++; BEGIN(MULTILINE_COMMENT); }

"+"                                                 { return T_PLUS; }
"-"                                                 { return T_MINUS; }
"*"                                                 { return T_MULT; }
"/"                                                 { return T_DIV; }
"%"                                                 { return T_MOD; }
"\\"                                                { return T_DBS; }
"^"                                                 { return T_POW; }
"<"                                                 { return T_LESS; }
"<="                                                { return T_LEQ; }
">="                                                { return T_GRQ; }
">"                                                 { return T_GRE; }
"="                                                 { return T_EQ; }
":="                                                { return T_EQ; }
"=="                                                { return T_EQTO; }
"!="                                                { return T_NOTEQ; }
"&&"                                                { return T_AND; }
"||"                                                { return T_OR; }
"!"                                                 { return T_NOT; }
";"                                                 { return T_SC; }
"."                                                 { return T_DOT; }
","                                                 { return T_COMMA; }
"("                                                 { return T_LEFTP; }
")"                                                 { return T_RIGHTP; }

{linefeed}                                          { yylineno++; }

.                                                   { InvalidToken(); }

<LINE_COMMENT>{
"\n"    { BEGIN(INITIAL); yylineno++; }
.       { }
}

<MULTILINE_COMMENT>{
"/*"    { count++; }
"*/"    { if (--count == 0) BEGIN(INITIAL); }
.|\n    { }
}

%%

void InvalidToken(){
    printf("ERROR ON LINE %d: Invalid Token %s\n", yylineno, yytext);
    exit(0);
}

int yywrap(void){
    return 1;
}
