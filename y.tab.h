/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TK_INT = 258,
    TK_REAL = 259,
    TK_BOOLEAN = 260,
    TK_CHAR = 261,
    TK_ID = 262,
    TK_MAIN = 263,
    TK_TIPO_INT = 264,
    TK_TIPO_BOOLEAN = 265,
    TK_TIPO_REAL = 266,
    TK_TIPO_CHAR = 267,
    TK_TIPO_ID = 268,
    TK_RESTO = 269,
    TK_MENOR = 270,
    TK_MAIOR = 271,
    TK_IGUAL = 272,
    TK_DIFERENTE = 273,
    TK_MENOR_IGUAL = 274,
    TK_MAIOR_IGUAL = 275,
    TK_AND = 276,
    TK_OR = 277,
    TK_NOT = 278,
    TK_ATRIBUICAO = 279,
    TK_CAST_INT = 280,
    TK_CAST_FLOAT = 281,
    TK_CIN = 282,
    TK_COUT = 283,
    TK_IF = 284,
    TK_WHILE = 285,
    TK_FOR = 286,
    TK_ELSE = 287,
    TK_ELSE_IF = 288,
    TK_DO = 289,
    TK_FIM_IF = 290,
    TK_FIM_FOR = 291,
    TK_FIM_WHILE = 292,
    TK_FIM_ELSE_IF = 293,
    TK_FIM_ELSE = 294,
    TK_FIM = 295,
    TK_ERROR = 296
  };
#endif
/* Tokens.  */
#define TK_INT 258
#define TK_REAL 259
#define TK_BOOLEAN 260
#define TK_CHAR 261
#define TK_ID 262
#define TK_MAIN 263
#define TK_TIPO_INT 264
#define TK_TIPO_BOOLEAN 265
#define TK_TIPO_REAL 266
#define TK_TIPO_CHAR 267
#define TK_TIPO_ID 268
#define TK_RESTO 269
#define TK_MENOR 270
#define TK_MAIOR 271
#define TK_IGUAL 272
#define TK_DIFERENTE 273
#define TK_MENOR_IGUAL 274
#define TK_MAIOR_IGUAL 275
#define TK_AND 276
#define TK_OR 277
#define TK_NOT 278
#define TK_ATRIBUICAO 279
#define TK_CAST_INT 280
#define TK_CAST_FLOAT 281
#define TK_CIN 282
#define TK_COUT 283
#define TK_IF 284
#define TK_WHILE 285
#define TK_FOR 286
#define TK_ELSE 287
#define TK_ELSE_IF 288
#define TK_DO 289
#define TK_FIM_IF 290
#define TK_FIM_FOR 291
#define TK_FIM_WHILE 292
#define TK_FIM_ELSE_IF 293
#define TK_FIM_ELSE 294
#define TK_FIM 295
#define TK_ERROR 296

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
