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
    TK_STRING = 262,
    TK_ID = 263,
    TK_MAIN = 264,
    TK_TIPO = 265,
    TK_TIPO_VAR = 266,
    TK_TIPO_STRING = 267,
    TK_ADD_SUB = 268,
    TK_MULT_DIV_RES = 269,
    TK_REL = 270,
    TK_LOGIC = 271,
    TK_ATRIBUICAO = 272,
    TK_CAST = 273,
    TK_IN = 274,
    TK_OUT = 275,
    TK_NOT = 276,
    TK_COND = 277,
    TK_COND1 = 278,
    TK_COND2 = 279,
    TK_LOOP = 280,
    TK_FIM = 281,
    TK_ERROR = 282,
    TK_BREAK = 283,
    TK_CONTINUE = 284
  };
#endif
/* Tokens.  */
#define TK_INT 258
#define TK_REAL 259
#define TK_BOOLEAN 260
#define TK_CHAR 261
#define TK_STRING 262
#define TK_ID 263
#define TK_MAIN 264
#define TK_TIPO 265
#define TK_TIPO_VAR 266
#define TK_TIPO_STRING 267
#define TK_ADD_SUB 268
#define TK_MULT_DIV_RES 269
#define TK_REL 270
#define TK_LOGIC 271
#define TK_ATRIBUICAO 272
#define TK_CAST 273
#define TK_IN 274
#define TK_OUT 275
#define TK_NOT 276
#define TK_COND 277
#define TK_COND1 278
#define TK_COND2 279
#define TK_LOOP 280
#define TK_FIM 281
#define TK_ERROR 282
#define TK_BREAK 283
#define TK_CONTINUE 284

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
