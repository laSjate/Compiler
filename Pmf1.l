%{
    #include<stdio.h>
    #include<stdlib.h>
    void yyerror(char*);
    void InvalidToken();
    int count = 0;
    int err_col = 1;
%}

linefeed    \n

%x LINE_COMMENT 
%x MULTILINE_COMMENT

%%
"true"|"false"                                      { printf("Bool: %s\n", yytext); err_col++; }
"IF"|"ELSE"|"FOR"|"WHILE"|"NEW"|"RETURN"|"VOID"|"INT"|"DOUBLE"|"FLOAT"|"CHAR"  { printf("Keyword: %s\n", yytext); err_col++; }
[a-zA-Z_][a-zA-Z0-9_]{0,30}                         { printf("Identifikator: %s\n", yytext); err_col++; }
(0x|0X)[0-9A-Fa-f]*                                 { printf("Hexa broj: %s\n", yytext); err_col++; }
[0-9]+                                              { printf("Cijeli broj: %s\n", yytext); err_col++; }
([0-9]*\.[0-9]+|[0-9]+\.)([Ee][+-]?[0-9]+)?         { printf("Float: %s\n", yytext); err_col++; }
\"[^\n"]+\"                                         { printf("String: %s\n", yytext); err_col++; }
[ \r\t]                                             { err_col++; }

"//"                                                { BEGIN(LINE_COMMENT); yylineno++; err_col++; }
"/*"                                                { count++; BEGIN(MULTILINE_COMMENT); yylineno++; err_col++; }

"+"                                                 { printf("%s\n",yytext); err_col++; }
"-"                                                 { printf("%s\n",yytext); err_col++; }
"*"                                                 { printf("%s\n",yytext); err_col++; }
"/"                                                 { printf("%s\n",yytext); err_col++; }
"%"                                                 { printf("%s\n",yytext); err_col++; }
"\\"                                                { printf("%s\n",yytext); err_col++; }
"<"                                                 { printf("%s\n",yytext); err_col++; }
"<="                                                { printf("%s\n",yytext); err_col++; }
">="                                                { printf("%s\n",yytext); err_col++; }
">"                                                 { printf("%s\n",yytext); err_col++; }
"="                                                 { printf("%s\n",yytext); err_col++; }
"=="                                                { printf("%s\n",yytext); err_col++; }
"!="                                                { printf("%s\n",yytext); err_col++; }
"&&"                                                { printf("%s\n",yytext); err_col++; }
"||"                                                { printf("%s\n",yytext); err_col++; }
"!"                                                 { printf("%s\n",yytext); err_col++; }
";"                                                 { printf("%s\n",yytext); err_col++; }
"."                                                 { printf("%s\n",yytext); err_col++; }
","                                                 { printf("%s\n",yytext); err_col++; }
"("                                                 { printf("%s\n",yytext); err_col++; }
")"                                                 { printf("%s\n",yytext); err_col++; }

{linefeed}                                          {yylineno++; err_col=0;}

.                                                   { InvalidToken();}

<LINE_COMMENT>{
"\n"    { BEGIN(INITIAL); }
.       { }
}

<MULTILINE_COMMENT>{
"/*"    { count++; }
"*/"    { if (--count > 0) ;
        else BEGIN(INITIAL); }
.|\n    { }
}


%%


void InvalidToken(){
    printf("ERROR ON LINE %d : AND COLUMN: %d  \n \t Invalid Token %s\n", yylineno, err_col,yytext);
    exit(0);
}


int yywrap(void){
    return 1;
}

int main(){

  yylex();
 
  return 0;
}