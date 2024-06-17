%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>
    #include "parser.h"
    #include "ast.h"

    void yyerror(const char* s);
    int yylex();
    extern int yylineno;

    struct ASTNode* root = NULL; // Glavni AST čvor
%}

%union {
    int int_value;
    double double_value;
    char* string;
    char* ident;
    struct ASTNode* astNode;
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

%type <astNode> program declarations ident_decl id_seq command_sequence command expression constant identifier type

%start program

%left T_EQ
%left T_OR
%left T_AND
%left T_EQTO T_NOTEQ
%left T_LESS T_LEQ T_GRQ T_GRE
%left T_PLUS T_MINUS
%left T_MULT T_DIV T_POW T_MOD
%right T_NOT

%%

program:
    T_LET declarations T_IN command_sequence T_END
    {
        root = createASTNode("program", "", $2, $4);
        printAST(root, 0);
        save_ast_to_dot(root, "ast.dot");
    }
;

declarations:
    {
        $$ = NULL;
    }
    | declarations type ident_decl
    {
        $$ = createASTNode("declarations", "", $1, $3);
    }
    
    
;

ident_decl:
    id_seq T_ID T_SC
    {
        $$ = createASTNode("ident_decl", $2, $1, NULL);
    }
    | id_seq T_ID T_DOT
    {
        $$ = createASTNode("ident_decl", $2, $1, NULL);
    }
;

id_seq:
    {
        $$ = NULL;
    }
    | id_seq T_ID T_COMMA
    {
        $$ = createASTNode("id_seq", $2, $1, NULL);
    }
    
;

command_sequence:
    {
        $$ = NULL;
    }
    | command_sequence command
    {
        $$ = createASTNode("command_sequence", "", $1, $2);
    }
;

command:
    T_SKIP T_SC
    {
        $$ = createASTNode("command", "skip", NULL, NULL);
    }
    | T_ID T_EQ expression T_SC
    {
        $$ = createASTNode("command", ":=", createASTNode("id", $1, NULL, NULL), $3);
    }
    | T_IF expression T_THEN command_sequence T_ELSE command_sequence T_FI T_SC
    {
        $$ = createASTNode("command", "if", $2, createASTNode("then_else", "", $4, $6));
    }
    | T_WHILE expression T_DO command_sequence T_END T_SC
    {
        $$ = createASTNode("command", "while", $2, $4);
    }
    | T_WHILE expression T_DO command_sequence T_BREAK T_SC T_END T_SC
    {
        $$ = createASTNode("command", "while", $2, createASTNode("command_sequence", "", $4, createASTNode("command", "break", NULL, NULL)));
    }
    | T_READ T_ID T_SC
    {
        $$ = createASTNode("command", "read", createASTNode("id", $2, NULL, NULL), NULL);
    }
    | T_WRITE expression T_SC
    {
        $$ = createASTNode("command", "write", $2, NULL);
    }
;

expression:
    constant
    {
        $$ = $1;
    }
    | identifier
    {
        $$ = $1;
    }
    | T_LEFTP expression T_RIGHTP
    {
        $$ = $2;
    }
    | expression T_PLUS expression
    {
        $$ = createASTNode("expression", "+", $1, $3);
    }
    | expression T_MINUS expression
    {
        $$ = createASTNode("expression", "-", $1, $3);
    }
    | expression T_MULT expression
    {
        $$ = createASTNode("expression", "*", $1, $3);
    }
    | expression T_DIV expression
    {
        $$ = createASTNode("expression", "/", $1, $3);
    }
    | expression T_EQTO expression
    {
        $$ = createASTNode("expression", "==", $1, $3);
    }
    | expression T_NOTEQ expression
    {
        $$ = createASTNode("expression", "!=", $1, $3);
    }
    | expression T_LESS expression
    {
        $$ = createASTNode("expression", "<", $1, $3);
    }
    | expression T_LEQ expression
    {
        $$ = createASTNode("expression", "<=", $1, $3);
    }
    | expression T_GRQ expression
    {
        $$ = createASTNode("expression", ">=", $1, $3);
    }
    | expression T_GRE expression
    {
        $$ = createASTNode("expression", ">", $1, $3);
    }
    | expression T_AND expression
    {
        $$ = createASTNode("expression", "&&", $1, $3);
    }
    | expression T_OR expression
    {
        $$ = createASTNode("expression", "||", $1, $3);
    }
    | expression T_POW expression
    {
        $$ = createASTNode("expression", "^", $1, $3);
    }
    | expression T_MOD expression
    {
        $$ = createASTNode("expression", "%", $1, $3);
    }
    | T_NOT expression
    {
        $$ = createASTNode("expression", "!", $2, NULL);
    }
;

constant:
    T_INT_CONST
    {
        char buffer[20];
        sprintf(buffer, "%d", $1);
        $$ = createASTNode("constant", buffer, NULL, NULL);
    }
    | T_DOUBLE_CONST
    {
        char buffer[20];
        sprintf(buffer, "%f", $1);
        $$ = createASTNode("constant", buffer, NULL, NULL);
    }
    | T_BOOL
    {
        char buffer[20];
        sprintf(buffer, "%d", $1);
        $$ = createASTNode("constant", buffer, NULL, NULL);
    }
    | T_STRING
    {
        $$ = createASTNode("constant", $1, NULL, NULL);
    }
;

identifier:
    T_ID
    {
        $$ = createASTNode("identifier", $1, NULL, NULL);
    }
;

type:
    T_INT
    {
        $$ = createASTNode("type", "int", NULL, NULL);
    }
    | T_DOUBLE
    {
        $$ = createASTNode("type", "double", NULL, NULL);
    }
    | T_BOOL
    {
        $$ = createASTNode("type", "bool", NULL, NULL);
    }
    | T_STRING
    {
        $$ = createASTNode("type", "string", NULL, NULL);
    }
    | T_VOID
    {
        $$ = createASTNode("type", "void", NULL, NULL);
    }
    | T_FLOAT
    {
        $$ = createASTNode("type", "float", NULL, NULL);
    }
    | T_CHAR
    {
        $$ = createASTNode("type", "char", NULL, NULL);
    }
    | T_UNION
    {
        $$ = createASTNode("type", "union", NULL, NULL);
    }
    | T_STRUCT
    {
        $$ = createASTNode("type", "struct", NULL, NULL);
    }
;

%%

void yyerror(const char* s){
    printf("ERROR ON LINE %d: %s\n", yylineno, s);
}