#include "ast.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ASTNode* createASTNode(const char* type, const char* value, struct ASTNode* left, struct ASTNode* right) {
    struct ASTNode* newNode = (struct ASTNode*)malloc(sizeof(struct ASTNode));
    newNode->type = strdup(type);
    newNode->value = strdup(value);
    newNode->left = left;
    newNode->right = right;
    return newNode;
}

void printAST(struct ASTNode* node, int level) {
    if (node == NULL) return;

    for (int i = 0; i < level; i++) {
        printf("  ");
    }
    printf("%s: %s\n", node->type, node->value);

    printAST(node->left, level + 1);
    printAST(node->right, level + 1);
}

void freeAST(struct ASTNode* node) {
    if (node == NULL) return;

    freeAST(node->left);
    freeAST(node->right);
    free(node->type);
    free(node->value);
    free(node);
}

void write_dot(struct ASTNode* node, FILE* file) {
    if (!node) return;

    if (node->left) {
        fprintf(file, "    \"%s_%s\" -> \"%s_%s\";\n", node->type, node->value, node->left->type, node->left->value);
        write_dot(node->left, file);
    }

    if (node->right) {
        fprintf(file, "    \"%s_%s\" -> \"%s_%s\";\n", node->type, node->value, node->right->type, node->right->value);
        write_dot(node->right, file);
    }
}

void save_ast_to_dot(struct ASTNode* root, const char* filename) {
    FILE* file = fopen(filename, "w");
    if (!file) {
        fprintf(stderr, "Could not open file %s for writing\n", filename);
        return;
    }

    fprintf(file, "digraph AST {\n");
    fprintf(file, "    node [shape=box];\n");

    int counter = 0;
    save_ast_node_to_dot(root, file, &counter);

    fprintf(file, "}\n");
    fclose(file);
}

void save_ast_node_to_dot(struct ASTNode* node, FILE* file, int* counter) {
    if (!node) return;

    int current_id = (*counter)++;
    fprintf(file, "    node%d [label=\"%s: %s\"];\n", current_id, node->type, node->value);

    if (node->left) {
        int left_id = *counter;
        save_ast_node_to_dot(node->left, file, counter);
        // Uklanjamo oznaku "left"
        fprintf(file, "    node%d -> node%d;\n", current_id, left_id);
    }

    if (node->right) {
        int right_id = *counter;
        save_ast_node_to_dot(node->right, file, counter);
        // Uklanjamo oznaku "right"
        fprintf(file, "    node%d -> node%d;\n", current_id, right_id);
    }
}

