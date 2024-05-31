/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_INT_CONST = 258,
     T_DOUBLE_CONST = 259,
     T_STRING = 260,
     T_BOOL = 261,
     T_ID = 262,
     T_HEX = 263,
     T_IF = 264,
     T_ELSE = 265,
     T_WHILE = 266,
     T_READ = 267,
     T_WRITE = 268,
     T_SKIP = 269,
     T_FI = 270,
     T_DO = 271,
     T_END = 272,
     T_IN = 273,
     T_LET = 274,
     T_THEN = 275,
     T_RETURN = 276,
     T_CONTINUE = 277,
     T_BREAK = 278,
     T_FOR = 279,
     T_PLUS = 280,
     T_MINUS = 281,
     T_MULT = 282,
     T_DIV = 283,
     T_MOD = 284,
     T_EQ = 285,
     T_EQTO = 286,
     T_NOTEQ = 287,
     T_LESS = 288,
     T_LEQ = 289,
     T_GRQ = 290,
     T_GRE = 291,
     T_AND = 292,
     T_OR = 293,
     T_NOT = 294,
     T_SC = 295,
     T_DOT = 296,
     T_COMMA = 297,
     T_LEFTP = 298,
     T_RIGHTP = 299,
     T_DBS = 300,
     T_POW = 301,
     T_VOID = 302,
     T_INT = 303,
     T_DOUBLE = 304,
     T_FLOAT = 305,
     T_CHAR = 306,
     T_UNION = 307,
     T_STRUCT = 308
   };
#endif
/* Tokens.  */
#define T_INT_CONST 258
#define T_DOUBLE_CONST 259
#define T_STRING 260
#define T_BOOL 261
#define T_ID 262
#define T_HEX 263
#define T_IF 264
#define T_ELSE 265
#define T_WHILE 266
#define T_READ 267
#define T_WRITE 268
#define T_SKIP 269
#define T_FI 270
#define T_DO 271
#define T_END 272
#define T_IN 273
#define T_LET 274
#define T_THEN 275
#define T_RETURN 276
#define T_CONTINUE 277
#define T_BREAK 278
#define T_FOR 279
#define T_PLUS 280
#define T_MINUS 281
#define T_MULT 282
#define T_DIV 283
#define T_MOD 284
#define T_EQ 285
#define T_EQTO 286
#define T_NOTEQ 287
#define T_LESS 288
#define T_LEQ 289
#define T_GRQ 290
#define T_GRE 291
#define T_AND 292
#define T_OR 293
#define T_NOT 294
#define T_SC 295
#define T_DOT 296
#define T_COMMA 297
#define T_LEFTP 298
#define T_RIGHTP 299
#define T_DBS 300
#define T_POW 301
#define T_VOID 302
#define T_INT 303
#define T_DOUBLE 304
#define T_FLOAT 305
#define T_CHAR 306
#define T_UNION 307
#define T_STRUCT 308




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 13 "parser.y"
{
    int int_value;
    double double_value;
    char* string;
    char* ident;
}
/* Line 1529 of yacc.c.  */
#line 162 "parser.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

