%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>
    #include "parser.h"

    void yyerror(const char* s);
    int yylex();
    extern int yylineno;
%}

%union {
    int int_value;
    double double_value;
    char* string;
    char* ident;
}

%token <int_value> T_INT_CONST
%token <double_value> T_DOUBLE_CONST
%token <string> T_STRING
%token <int_value> T_BOOL
%token <ident> T_ID
%token <string> T_HEX

%token T_IF T_ELSE T_WHILE T_READ T_WRITE T_SKIP T_FI T_DO T_END T_IN T_LET T_THEN T_RETURN T_CONTINUE T_BREAK T_FOR
%token T_PLUS T_MINUS T_MULT T_DIV T_MOD T_EQ T_EQTO T_NOTEQ T_LESS T_LEQ T_GRQ T_GRE T_AND T_OR T_NOT T_SC T_DOT T_COMMA T_LEFTP T_RIGHTP T_DBS T_POW
%token T_VOID T_INT T_DOUBLE T_FLOAT T_CHAR T_UNION T_STRUCT 

%start program

%left T_EQ
%left T_OR
%left T_AND
%left T_EQTO T_NOTEQ
%left T_LESS T_LEQ T_GRQ T_GRE
%left T_PLUS T_MINUS
%left T_MULT T_DIV T_POW
%right T_NOT

%%

program:
    T_LET declarations T_IN command_sequence T_END
;

declarations:
    
    | declarations type ident_decl 
;

ident_decl:
    id_seq T_ID T_SC 
    | id_seq T_ID T_DOT
;

id_seq:
    
    | id_seq T_ID T_COMMA 
;

command_sequence:
     
    | command_sequence command 
;

command:
    T_SKIP T_SC 
    | T_ID T_EQ expression T_SC 
    | T_IF expression T_THEN command_sequence T_ELSE command_sequence T_FI T_SC 
    | T_WHILE expression T_DO command_sequence T_END T_SC 
    | T_WHILE expression T_DO command_sequence T_BREAK T_SC T_END T_SC
    | T_READ T_ID T_SC 
    | T_WRITE expression T_SC { printf("Kraj koda\n"); }
;

expression:
    constant 
    | identifier 
    | T_LEFTP expression T_RIGHTP 
    | expression T_PLUS expression 
    | expression T_MINUS expression 
    | expression T_MULT expression 
    | expression T_DIV expression 
    | expression T_EQTO expression 
    | expression T_NOTEQ expression 
    | expression T_LESS expression 
    | expression T_LEQ expression 
    | expression T_GRQ expression 
    | expression T_GRE expression 
    | expression T_AND expression 
    | expression T_OR expression 
    | expression T_POW expression 
    | T_NOT expression  
;

constant:
    T_INT_CONST 
    | T_DOUBLE_CONST 
    | T_BOOL 
    | T_STRING 
;

identifier:
    T_ID   
;

type:
    T_INT 
    | T_DOUBLE 
    | T_BOOL 
    | T_STRING 
    | T_VOID 
    | T_FLOAT 
    | T_CHAR 
    | T_UNION 
    | T_STRUCT 
;

%%

void yyerror(const char* s){
    printf("ERROR ON LINE %d: %s\n", yylineno, s);
}
