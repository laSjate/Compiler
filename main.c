#include <stdio.h>
#include <stdlib.h>
#include "skener.h"
#include "parser.h"
#include "ast.h"

int yyparse();
extern FILE *yyin;
extern struct ASTNode* root;

int main(int argc, char **argv) {
    FILE *file = fopen("test.txt", "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }
    yyin = file;
    yyparse();
    fclose(file);

    if (root) {
        save_ast_to_dot(root, "ast.dot");
        printf("AST saved to ast.dot\n");
    } else {
        printf("No AST generated.\n");
    }
    return 0;
}