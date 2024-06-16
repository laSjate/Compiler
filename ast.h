#ifndef AST_H
#define AST_H

struct ASTNode {
    char* type;
    char* value;
    struct ASTNode* left;
    struct ASTNode* right;
};

struct ASTNode* createASTNode(const char* type, const char* value, struct ASTNode* left, struct ASTNode* right);
void printAST(struct ASTNode* node, int level);
void freeAST(struct ASTNode* node);
void save_ast_to_dot(struct ASTNode* root, const char* filename);

#endif // AST_H
