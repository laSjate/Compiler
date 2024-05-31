#include <stdio.h>
#include <stdlib.h>
#include "skener.h"
#include "parser.h"

int yyparse();
int main(){
    int res = yyparse();
    if (res == 0) {
        printf("Ulaz je bio ispravan!\n");
    }
    else {
        printf("Ulaz nije bio ispravan!\n");
    }

    return 0;
}