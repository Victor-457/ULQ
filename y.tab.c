/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 37 "sintatica.y" /* yacc.c:339  */

#include <iostream>
#include <string.h>
#include <sstream>
#include <fstream>
#include <stdio.h>
#include <map>
#include <vector>

#define YYSTYPE atributos
#define true  1
#define false 0

using namespace std;

struct atributos
{
	string label;
	string traducao;
	string tipo;
	string tipo_traducao;
	int tamanho;
};

typedef struct
{
	string tipoRes;
	int retorno ;

}cast;

struct variavel
{
	string tipo;
	string nome;
	string valor;/* Na versão anterior este campo não existia, pois o valor já era atribuido na mesma linha do código intermediário então ele não era necessário.*/
	string tam;
};

typedef map<string,cast> mapaCast;
typedef map<string,variavel> mapaVar;

vector<map<string,variavel>> pilhaVar;// pilha utilizada para armazenar os mapas de variaveis, ela sempre começa com as variaveis globais
int pilhaPos = -1;

int linha = 1;
string erro;
static int numero = -1;
static mapaCast mapCast;
static mapaVar mapVar;

void addVarMap(string,string,string,string);
void setTamString(string,string);
void alteraValor(string,string);
void mudaTipo(string,string);
void buscaMapa(string,int);
void empilhaNovoMapa();
void preencheMapCast();
void yyerror(string);

string declara_variaveis_temp(mapaVar,int);
string geraId(string,string,string);
string retornaValor(string);
string retornaNome(string);
string retornaTipo(string);
string geraLabel();

int verificaCast(string,string,string);
int verificaDeclaracao(string);
int yylex(void);


#line 139 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
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
    TK_LOOP = 278,
    TK_FIM = 279,
    TK_ERROR = 280
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
#define TK_LOOP 278
#define TK_FIM 279
#define TK_ERROR 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 240 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   108

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  32
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  20
/* YYNRULES -- Number of rules.  */
#define YYNRULES  58
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  103

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   280

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      26,    27,     2,     2,     2,    31,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    30,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    28,     2,    29,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   126,   126,   135,   139,   150,   154,   156,   160,   163,
     164,   165,   166,   167,   170,   196,   198,   227,   257,   285,
     315,   344,   382,   423,   465,   489,   494,   513,   532,   584,
     621,   660,   710,   747,   797,   837,   875,   903,   929,   936,
     952,   978,   994,  1017,  1032,  1061,  1066,  1272,  1479,  1484,
    1490,  1686,  1731,  1833,  1882,  1905,  1920,  1924,  1939
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TK_INT", "TK_REAL", "TK_BOOLEAN",
  "TK_CHAR", "TK_STRING", "TK_ID", "TK_MAIN", "TK_TIPO", "TK_TIPO_VAR",
  "TK_TIPO_STRING", "TK_ADD_SUB", "TK_MULT_DIV_RES", "TK_REL", "TK_LOGIC",
  "TK_ATRIBUICAO", "TK_CAST", "TK_IN", "TK_OUT", "TK_NOT", "TK_COND",
  "TK_LOOP", "TK_FIM", "TK_ERROR", "'('", "')'", "'{'", "'}'", "';'",
  "'-'", "$accept", "S", "BLOCOGLOBAL", "BLOCO", "D", "COMANDOS",
  "COMANDO", "STRING", "DECLARA", "ALTERA", "TERM", "OP_ARIT", "OUTRA_OP",
  "OP_REL", "OP_LOG", "OP_LOG1", "CAST", "IN", "OUT", "T", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,    40,    41,   123,   125,
      59,    45
};
# endif

#define YYPACT_NINF -50

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-50)))

#define YYTABLE_NINF -34

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -50,     1,   -50,   -50,    15,   -17,    11,    14,    35,   -50,
      12,    17,    41,   -50,    42,   -50,    32,     2,    59,    43,
     -50,    37,    38,    39,    40,   -50,     0,    63,    44,    68,
       4,   -50,   -50,   -50,   -50,    56,    66,    50,    51,    49,
      43,    52,    53,   -50,    54,    55,    57,    58,   -50,   -50,
     -50,   -50,   -50,   -50,    76,    65,    62,   -50,    44,    44,
      44,     8,   -50,    73,    28,   -50,   -50,   -50,   -50,   -50,
     -50,   -50,   -50,    44,   -50,    77,   -50,   -50,   -50,    61,
      64,    67,    69,    34,    44,   -50,   -50,   -50,    71,    28,
      28,    74,   -50,    44,    70,   -50,    75,   -50,   -50,   -50,
     -50,   -50,   -50
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       3,     0,     6,     1,     0,     0,     0,     0,     0,    15,
       0,     0,    26,    27,     0,     5,     0,     0,     0,     8,
       2,    39,    41,    44,    43,    45,     0,     0,     0,     0,
       0,    22,    24,    25,    14,     0,     0,     0,     0,     0,
       8,     0,     0,    38,     0,     0,     0,    40,    19,    51,
      39,    41,    44,    43,     0,     0,     0,    42,     0,     0,
       0,     0,    53,     0,    58,     4,     7,     9,    13,    12,
      10,    11,    40,     0,    23,    49,    46,    47,    52,    39,
      41,    44,    43,     0,     0,    34,    36,    37,     0,    58,
      58,     0,    50,     0,    40,    31,     0,    54,    56,    57,
      55,    48,    35
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -50,   -50,   -50,   -50,   -50,    46,   -50,   -50,    88,   -50,
     -28,    45,     3,     9,   -15,    47,   -50,   -50,   -50,   -49
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     2,    20,     4,    39,    40,     9,    41,    42,
      30,    31,    76,    56,    43,    33,    44,    45,    46,    91
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      55,     3,    32,    47,    48,    21,    22,    23,    24,    11,
      25,    79,    80,    81,    82,    26,    25,    58,    59,    12,
      60,    83,    13,    27,     5,     6,     7,     8,    28,    27,
      75,    77,    78,    29,    84,    89,    90,    94,    95,    29,
      98,    99,    15,    14,    16,    92,    86,    50,    51,    52,
      53,    35,    25,     6,     7,     8,    55,    54,    17,    18,
      19,    36,    37,    38,    27,    75,    34,   -16,   -18,   -21,
     -20,    49,    57,    61,    62,    29,    63,    64,    65,    72,
      73,    88,    67,    68,    69,    70,    66,    71,   -17,    74,
      93,   -32,    10,    96,   -30,     0,   101,   -28,    97,   -29,
     -33,   100,   102,     0,     0,     0,    85,     0,    87
};

static const yytype_int8 yycheck[] =
{
      28,     0,    17,     3,     4,     3,     4,     5,     6,    26,
       8,     3,     4,     5,     6,    13,     8,    13,    14,     8,
      16,    13,     8,    21,     9,    10,    11,    12,    26,    21,
      58,    59,    60,    31,    26,     7,     8,     3,     4,    31,
      89,    90,    30,     8,    27,    73,    61,     3,     4,     5,
       6,     8,     8,    10,    11,    12,    84,    13,    17,    17,
      28,    18,    19,    20,    21,    93,     7,    30,    30,    30,
      30,     8,     4,    17,     8,    31,    26,    26,    29,     3,
      15,     8,    30,    30,    30,    30,    40,    30,    30,    27,
      13,    30,     4,    84,    30,    -1,    93,    30,    27,    30,
      30,    27,    27,    -1,    -1,    -1,    61,    -1,    61
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    33,    34,     0,    36,     9,    10,    11,    12,    39,
      40,    26,     8,     8,     8,    30,    27,    17,    17,    28,
      35,     3,     4,     5,     6,     8,    13,    21,    26,    31,
      42,    43,    46,    47,     7,     8,    18,    19,    20,    37,
      38,    40,    41,    46,    48,    49,    50,     3,     4,     8,
       3,     4,     5,     6,    13,    42,    45,     4,    13,    14,
      16,    17,     8,    26,    26,    29,    37,    30,    30,    30,
      30,    30,     3,    15,    27,    42,    44,    42,    42,     3,
       4,     5,     6,    13,    26,    43,    46,    47,     8,     7,
       8,    51,    42,    13,     3,     4,    45,    27,    51,    51,
      27,    44,    27
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    32,    33,    34,    35,    36,    36,    37,    37,    38,
      38,    38,    38,    38,    39,    40,    40,    40,    40,    40,
      40,    40,    40,    40,    40,    40,    40,    40,    41,    41,
      41,    41,    41,    41,    41,    41,    41,    41,    41,    42,
      42,    42,    42,    42,    42,    42,    43,    43,    44,    44,
      45,    46,    47,    48,    49,    50,    51,    51,    51
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     6,     0,     3,     3,     0,     2,     0,     2,
       2,     2,     2,     2,     4,     1,     4,     5,     4,     5,
       4,     4,     4,     6,     4,     4,     2,     2,     3,     3,
       3,     4,     3,     4,     3,     5,     3,     3,     1,     1,
       2,     1,     2,     1,     1,     1,     3,     3,     3,     1,
       3,     2,     3,     2,     4,     4,     2,     2,     0
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 127 "sintatica.y" /* yacc.c:1646  */
    {
				string s = declara_variaveis_temp(pilhaVar[pilhaPos],0);
				cout << "/*Compilador Uma Linguagem Qualquer*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\n\nusing namespace std;\n"<< s <<(yyvsp[-4]).traducao << "\nint main(void)\n{\n" << (yyvsp[0]).traducao << "\treturn 0;\n}" << endl;
			}
#line 1387 "y.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 135 "sintatica.y" /* yacc.c:1646  */
    {
					empilhaNovoMapa();
			}
#line 1395 "y.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 140 "sintatica.y" /* yacc.c:1646  */
    {

				pilhaPos = pilhaVar.size() - 1; // Pego o topo da pilha
				string s = declara_variaveis_temp(pilhaVar[pilhaPos],1);
				(yyval).traducao = s + (yyvsp[-1]).traducao;
				pilhaVar.pop_back();// desempilho o mapa ao final do bloco
				pilhaPos = pilhaVar.size() - 1;
			}
#line 1408 "y.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 151 "sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-2]).traducao + (yyvsp[-1]).traducao;
			}
#line 1416 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 157 "sintatica.y" /* yacc.c:1646  */
    {
				(yyval).traducao = (yyvsp[-1]).traducao + (yyvsp[0]).traducao;
			}
#line 1424 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 171 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[-2]).label,1);

				if(verificaDeclaracao((yyvsp[-2]).label) == 1){
					
					erro = "Erro de Semântica na Linha : Eu to na string " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 0){
					
					(yyval).label = geraLabel();
					
					addVarMap((yyvsp[-3]).tipo,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).label);
					
					string tam = to_string((yyvsp[0]).tamanho);
					setTamString((yyvsp[-2]).label,tam);
					
					(yyval).traducao = "strcpy(" + (yyval).label + "," + (yyvsp[0]).label + ");\n\n" ;
				}


			}
#line 1452 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 199 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-3]).label=="int"){

					buscaMapa((yyvsp[-2]).label,1);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha :  eu to na declaracao de int atribuindo valor" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-2]).label) == 0){

						(yyval).label = geraLabel();
						(yyval).traducao = (yyval).label + " = " + (yyvsp[0]).label + ";\n";

						addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).label);
					}
				}

				else{

					erro = "Erro de Semântica na Linha :  eu to na declaracao de int atribuindo valor2" + to_string(linha);
					yyerror(erro);
				}
			}
#line 1484 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 228 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-4]).label == "int" && (yyvsp[-1]).label == "-"){

					buscaMapa((yyvsp[-3]).label,1);

					if(verificaDeclaracao((yyvsp[-3]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id 	já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de int atribuindo valor negativo" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-3]).label) == 0){

						(yyval).label = geraLabel();
						string temp = "-" + (yyvsp[0]).label;
						(yyval).traducao = (yyval).label + " = " + temp + ";\n";

						addVarMap((yyvsp[-4]).label,(yyvsp[-3]).label,(yyval).label,temp);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de int atribuindo valor negativo " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1517 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 258 "sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[-3]).label == "float"){

					buscaMapa((yyvsp[-2]).label,1);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id 	já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de real atribuindo valor " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-2]).label) == 0){

						(yyval).label = geraLabel();
						(yyval).traducao = (yyval).label + " = " + (yyvsp[0]).label + ";\n";

						addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).label);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de real atribuindo valor2 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1548 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 286 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-4]).label == "float" && (yyvsp[-1]).label == "-"){

					buscaMapa((yyvsp[-3]).label,1);

					if(verificaDeclaracao((yyvsp[-3]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id 	já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de real atribuindo valor negativo " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-3]).label) == 0){

						(yyval).label = geraLabel();
						string temp = "-" + (yyvsp[0]).label;
						(yyval).traducao = (yyval).label + " = " + temp + ";\n";

						addVarMap((yyvsp[-4]).label,(yyvsp[-3]).label,(yyval).label,temp);
					}
				}

				else{

					erro = "Erro de Semântica na Linha :  eu to na declaracao de real atribuindo valor negativo" + to_string(linha);
					yyerror(erro);
				}
			}
#line 1581 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 316 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-3]).label == "char"){

					buscaMapa((yyvsp[-2]).label,1);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de char atribuindo valor " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-2]).label) == 0){

						(yyval).label = geraLabel();
						(yyval).traducao = (yyval).label + " = " + (yyvsp[0]).label + ";\n";

						addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).label);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de char atribuindo valor2 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1613 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 345 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-3]).label == "bool"){

					buscaMapa((yyvsp[-2]).label,1);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de boolean atribuindo valor " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-2]).label) == 0){

						(yyval).label = geraLabel();

						if((yyvsp[0]).label=="true"){

							(yyval).traducao = (yyval).label + " = " + "1" + ";\n";
							addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,"1");
						}

						else if((yyvsp[0]).label == "false"){

							(yyval).traducao = (yyval).label + " = " + "0" + ";\n";
							addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,"0");
						}
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de boolean atribuindo valor2 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1654 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 383 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[-2]).label,1);

				if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

					erro = "Erro de Semântica na Linha : eu to na declaracao de exp ARIT atribuindo valor " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 0){

					(yyval).label = geraLabel();

					if((yyvsp[-3]).label == (yyvsp[0]).tipo){

						if((yyvsp[0]).label == "NULL"){

							(yyval).traducao = (yyval).label + " = " + (yyvsp[0]).tipo_traducao + " ;\n\n";

							addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).tipo_traducao);
						}

						else{

							//cout<<$4.label<<endl<<endl<<$$.label<<endl<<$4.tipo_traducao<<endl;

							(yyval).traducao = (yyvsp[0]).label + (yyval).label + " = " + (yyvsp[0]).tipo_traducao + " ;\n\n";

							addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).tipo_traducao);
						}
					}

					else{

						erro = "Erro de Semântica na Linha : eu to na declaracao de expressões atribuindo valor2 (tipo da variavel que vai receber a exp esta errado) " + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 1698 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 424 "sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[-5]).label == "bool"){

					buscaMapa((yyvsp[-4]).label,1);

					if(verificaDeclaracao((yyvsp[-4]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de exp REL atribuindo valor(variavel ja existente) " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-4]).label) == 0){

						(yyval).label = geraLabel();

						if((yyvsp[-1]).label == "NULL"){

							(yyval).traducao = (yyval).label + " = " + (yyvsp[-1]).tipo_traducao + " ;\n\n";

							addVarMap((yyvsp[-5]).label,(yyvsp[-4]).label,(yyval).label,(yyvsp[-1]).tipo_traducao);
						}

						else{

							(yyval).traducao = (yyvsp[-1]).label + (yyval).label + " = " + (yyvsp[-1]).tipo_traducao + " ;\n\n";

							addVarMap((yyvsp[-5]).label,(yyvsp[-4]).label,(yyval).label,(yyvsp[-1]).tipo_traducao);
						}

					}


				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de expressões atribuindo valor3(Relacional)(tipo da variavel que vai receber a exp esta errado) " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1743 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 466 "sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[-3]).label == "bool"){

					buscaMapa((yyvsp[-2]).label,1);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de exp REL atribuindo valor(variavel ja existente) " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao((yyvsp[-2]).label) == 0){


						(yyval).label = geraLabel();

						(yyval).traducao = (yyval).label +  (yyvsp[0]).label;

						addVarMap((yyvsp[-3]).label,(yyvsp[-2]).label,(yyval).label,(yyvsp[0]).tipo_traducao);
					}
				}
			}
#line 1770 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 490 "sintatica.y" /* yacc.c:1646  */
    {
				//**************Definir conteudo*****************************************
			}
#line 1778 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 495 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[0]).label,1);

				if(verificaDeclaracao((yyvsp[0]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

					erro = "Erro de Semântica na Linha : eu to na declaracao de variavel sem atribuir valor " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[0]).label) == 0){

						(yyval).label = geraLabel();
						addVarMap((yyvsp[-1]).label,(yyvsp[0]).label,(yyval).label,"");

				}
			}
#line 1800 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 514 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[0]).label,1);

				if(verificaDeclaracao((yyvsp[0]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

					erro = "Erro de Semântica na Linha :  to no qualquer" + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[0]).label) == 0){

					(yyval).label = geraLabel();
					addVarMap((yyvsp[-1]).label,(yyvsp[0]).label,(yyval).label,"");
				}
			}
#line 1821 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 533 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[-2]).label,0);
				if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if((yyvsp[0]).tipo == temp){

						if((yyvsp[0]).label == "true"){
							alteraValor((yyvsp[-2]).label,"1");
							(yyval).traducao = tempLabel + " = 1;\n"; // Printa no código intermediário a alteração
						}

						else if((yyvsp[0]).label == "false"){
							alteraValor((yyvsp[-2]).label,"0");
							(yyval).traducao = tempLabel + " = 0;\n";
						}
					}
					else if(temp == ""){

						mudaTipo((yyvsp[-2]).label,"int");

						if((yyvsp[0]).label == "true"){

							alteraValor((yyvsp[-2]).label,"1");
							(yyval).traducao = tempLabel + " = 1;\n"; // Printa no código intermediário a alteração
						}

						else if((yyvsp[0]).label == "false"){

							alteraValor((yyvsp[-2]).label,"0");
							(yyval).traducao = tempLabel + " = 0;\n";
						}

					}

					else if((yyvsp[0]).tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável boolean

						erro = "Erro de Semântica na Linha : eu to na altera boolean " + to_string(linha);
						yyerror(erro);
					}
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha :  eu to na altera boolean2" + to_string(linha);
					yyerror(erro);
				}
			}
#line 1876 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 585 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[-2]).label,0);
				if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if((yyvsp[0]).tipo == temp){

						alteraValor((yyvsp[-2]).label,(yyvsp[0]).label);
						(yyval).traducao =tempLabel + " = " + (yyvsp[0]).label + ";\n"; // Printa no código intermediário a alteração
					}

					else if(temp == ""){

						alteraValor((yyvsp[-2]).label,(yyvsp[0]).label);
						mudaTipo((yyvsp[-2]).label,(yyvsp[0]).tipo);

						(yyval).traducao = tempLabel + " = " + (yyvsp[0]).label + ";\n"; // Printa no código intermediário a alteração
					}

					else if((yyvsp[0]).tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável char

						erro = "Erro de Semântica na Linha : eu to na altera char " + to_string(linha);
						yyerror(erro);
					}
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha : eu to na altera char2 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1916 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 622 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[-2]).label,0);

				if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if((yyvsp[0]).tipo == temp){

						alteraValor((yyvsp[-2]).label,(yyvsp[0]).label);
						(yyval).traducao =tempLabel + " = " + (yyvsp[0]).label + ";\n"; // Printa no código intermediário a alteração
					}

					else if(temp == ""){

						alteraValor((yyvsp[-2]).label,(yyvsp[0]).label);
						mudaTipo((yyvsp[-2]).label,(yyvsp[0]).tipo);

						(yyval).traducao = tempLabel + " = " + (yyvsp[0]).label + ";\n"; // Printa no código intermediário a alteração
					}

					else if((yyvsp[0]).tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável real

						erro = "Erro de Semântica na Linha : eu to na altera real " + to_string(linha);
						yyerror(erro);

					}
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha : eu to na altera real 2 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 1958 "y.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 661 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-1]).label == "-"){

					buscaMapa((yyvsp[-3]).label,0);

					if(verificaDeclaracao((yyvsp[-3]).label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						string temp = retornaTipo((yyvsp[-3]).label);
						string tempLabel = retornaNome((yyvsp[-3]).label);

						if((yyvsp[0]).tipo == temp){

							string tempV = "-" + (yyvsp[0]).label;
							alteraValor((yyvsp[-3]).label,tempV);

							(yyval).traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if(temp == ""){

							string tempV = "-" + (yyvsp[0]).label;
							alteraValor((yyvsp[-3]).label,tempV);
							mudaTipo((yyvsp[-3]).label,(yyvsp[0]).tipo);

							(yyval).traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if((yyvsp[0]).tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável real

							erro = "Erro de Semântica na Linha : eu to na altera real negativo " + to_string(linha);
							yyerror(erro);
						}
					}

					else if(verificaDeclaracao((yyvsp[-3]).label) == 0){// Variavel não declarada

						erro = "Erro de Semântica na Linha : eu to na altera real negativo2 " + to_string(linha);
						yyerror(erro);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na altera real negativo3 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 2011 "y.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 711 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[-2]).label,0);

				if(verificaDeclaracao((yyvsp[-2]).label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if((yyvsp[0]).tipo == temp){

						alteraValor((yyvsp[-2]).label,(yyvsp[0]).label);
						(yyval).traducao = tempLabel + " = " + (yyvsp[0]).label + ";\n"; // Printa no código intermediário a alteração
					}

					else if(temp == ""){

						alteraValor((yyvsp[-2]).label,(yyvsp[0]).label);
						mudaTipo((yyvsp[-2]).label,(yyvsp[0]).tipo);

						(yyval).traducao = tempLabel + " = " + (yyvsp[0]).label + ";\n"; // Printa no código intermediário a alteração
					}

					else if((yyvsp[0]).tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável inteira

						erro = "Erro de Semântica na Linha : eu to na altera int " + to_string(linha);
						yyerror(erro);
					}
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha : eu to na altera int2 " + to_string(linha);
					yyerror(erro);
				}
			}
#line 2051 "y.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 748 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-1]).label == "-"){

					buscaMapa((yyvsp[-3]).label,0);

					if(verificaDeclaracao((yyvsp[-3]).label) == 1){ // Está alterandor uma variavel já existente, ou seja está usando um id já declarado.

						string temp = retornaTipo((yyvsp[-3]).label);
						string tempLabel = retornaNome((yyvsp[-3]).label);

						if((yyvsp[0]).tipo == temp){

							string tempV = "-" + (yyvsp[0]).label;
							alteraValor((yyvsp[-3]).label,tempV);

							(yyval).traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if(temp == ""){

							string tempV = "-" + (yyvsp[0]).label;
							alteraValor((yyvsp[-3]).label,tempV);
							mudaTipo((yyvsp[-3]).label,(yyvsp[0]).tipo);

							(yyval).traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if((yyvsp[0]).tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável inteira

							erro = "Erro de Semântica na Linha : eu to na altera int negativo " + to_string(linha);
							yyerror(erro);
						}
					}

					else if(verificaDeclaracao((yyvsp[-3]).label) == 0){ // Variavel não declarada

						erro = "Erro de Semântica na Linha :  eu to na altera int negativo2" + to_string(linha);
						yyerror(erro);
					}
				}

				else{

					erro = "Erro de Semântica na Linha :  eu to na altera int negativo3" + to_string(linha);
					yyerror(erro);
				}
			}
#line 2104 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 798 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[-2]).label,0);

				if(verificaDeclaracao((yyvsp[-2]).label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões  arit " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 1){

					string tempTipo = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if(tempTipo == (yyvsp[0]).tipo){

						if((yyvsp[0]).label == "NULL"){

							alteraValor((yyvsp[-2]).label,(yyvsp[0]).tipo_traducao);
							(yyval).traducao = tempLabel + " = " + (yyvsp[0]).tipo_traducao + " ;\n\n";
						}

						else{
							alteraValor((yyvsp[-2]).label,(yyvsp[0]).tipo_traducao);
							(yyval).traducao = (yyvsp[0]).label + tempLabel + " = " + (yyvsp[0]).tipo_traducao + " ;\n\n";
						}

					}

					else{
						erro = "Erro de Semântica na Linha : eu to na altera com expressões arit2  " + to_string(linha);
						yyerror(erro);
					}


				}
			}
#line 2147 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 838 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[-4]).label,0);

				if(verificaDeclaracao((yyvsp[-4]).label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões REL " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[-4]).label) == 1){

					string tempTipo = retornaTipo((yyvsp[-4]).label);
					string tempLabel = retornaNome((yyvsp[-4]).label);

					if(tempTipo == "bool"){

						if((yyvsp[-1]).label == "NULL"){

							alteraValor((yyvsp[-4]).label,(yyvsp[-1]).tipo_traducao);
							(yyval).traducao = tempLabel + " = " + (yyvsp[-1]).tipo_traducao + " ;\n\n";
						}

						else{
							alteraValor((yyvsp[-4]).label,(yyvsp[-1]).tipo_traducao);
							(yyval).traducao = (yyvsp[-1]).label + tempLabel + " = " + (yyvsp[-1]).tipo_traducao + " ;\n\n";
						}

					}

					else{
						erro = "Erro de Semântica na Linha : eu to na altera com expressões REL 2  " + to_string(linha);
						yyerror(erro);
					}

				}
			}
#line 2188 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 876 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[-2]).label,0);

				if(verificaDeclaracao((yyvsp[-2]).label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões  not3 " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 1){

					string tempTipo = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if(tempTipo == "bool" || tempTipo == "boolean"){
						alteraValor((yyvsp[-2]).label,(yyvsp[0]).tipo);

						(yyval).traducao = tempLabel + " " + (yyvsp[0]).label;
					}
					else{
						erro = "Erro de Semântica na Linha : eu to no OP not 4 " + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 2219 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 904 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[-2]).label,0);

				if(verificaDeclaracao((yyvsp[-2]).label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões  OP_LOG1 " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao((yyvsp[-2]).label) == 1){
					string tempTipo = retornaTipo((yyvsp[-2]).label);
					string tempLabel = retornaNome((yyvsp[-2]).label);

					if(tempTipo == "bool" || tempTipo == "boolean"){
						alteraValor((yyvsp[-2]).label,(yyvsp[0]).tipo);

						(yyval).traducao = tempLabel + " " + (yyvsp[0]).label;
					}
					else{
						erro = "Erro de Semântica na Linha : eu to no OP_LOG1 2 " + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 2248 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 930 "sintatica.y" /* yacc.c:1646  */
    {
				buscaMapa((yyvsp[0]).traducao,0);
				(yyval).traducao = (yyvsp[0]).tipo_traducao;
			}
#line 2257 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 937 "sintatica.y" /* yacc.c:1646  */
    {
		    	buscaMapa((yyvsp[0]).label,0);

		    	if(verificaDeclaracao((yyvsp[0]).label) == 0){

		    		string nome = geraLabel();
	    	 		(yyval).label = (yyvsp[0]).label;
		    		(yyval).tipo = (yyvsp[0]).tipo;

					(yyval).traducao = nome + " = " + (yyval).label + ";\n";

		    		addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
		    	}
		    }
#line 2276 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 953 "sintatica.y" /* yacc.c:1646  */
    {

				(yyval).label = "-" + (yyvsp[0]).label;

				buscaMapa((yyval).label,0);

		    	if(verificaDeclaracao((yyval).label) == 0){

					if((yyvsp[-1]).label == "-"){

						string nome = geraLabel();
			    		(yyval).tipo = (yyvsp[0]).tipo;
						(yyval).traducao = nome + " = " + (yyval).label + ";\n";

			    		addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
			    	}

		    		else{

						erro = "Erro de Semântica na Linha : eu to no term int negativo " + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 2305 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 979 "sintatica.y" /* yacc.c:1646  */
    {

	    		buscaMapa((yyvsp[0]).label,0);

		    	if(verificaDeclaracao((yyvsp[0]).label) == 0){

			    	string nome = geraLabel();
	    		 	(yyval).label = (yyvsp[0]).label;
		    		(yyval).tipo = (yyvsp[0]).tipo;
		    		(yyval).traducao = nome + " = " + (yyval).label + ";\n";

		    		addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
			    }
			}
#line 2324 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 995 "sintatica.y" /* yacc.c:1646  */
    {
				(yyval).label = "-" + (yyvsp[0]).label;

				buscaMapa((yyval).label,0);

		    	if(verificaDeclaracao((yyval).label) == 0){

					if((yyvsp[-1]).label == "-"){
						string nome = geraLabel();
			    		(yyval).tipo = (yyvsp[0]).tipo;
			    		(yyval).traducao = nome + " = " + (yyval).label + ";\n";

			    		addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
			    	}
			    	else{

						erro = "Erro de Semântica na Linha : eu to no term real negativo " + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 2350 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 1018 "sintatica.y" /* yacc.c:1646  */
    {
		    	buscaMapa((yyvsp[0]).label,0);

		    	if(verificaDeclaracao((yyval).label) == 0){

		    		string nome = geraLabel();
	    	 		(yyval).label = (yyvsp[0]).label;
		    		(yyval).tipo = (yyvsp[0]).tipo;
		    		(yyval).traducao = nome + " = " + (yyval).label + ";\n";

		    		addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
		    	}
			}
#line 2368 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 1033 "sintatica.y" /* yacc.c:1646  */
    {
		   		/* adiciona a variavel boolean autilizada num mapa de variaveis com tipo igual a int e id igual a 1 ou 0 se ele já não estiver lá */
		     	if(verificaDeclaracao((yyvsp[0]).label)==0){

		   	 		(yyval).label = geraLabel();

		    		if((yyvsp[0]).label == "true"){

		    			string nome = geraLabel();
	    	 			(yyval).label = "1";
		    			(yyval).tipo = (yyvsp[0]).tipo;
		    			(yyval).traducao = nome + " = " + (yyval).label + ";\n";

		    			addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
		    		}

		    		else if((yyvsp[0]).label == "false"){

		    			string nome = geraLabel();
	    	 			(yyval).label = "0";
		    			(yyval).tipo = (yyvsp[0]).tipo;
		    			(yyval).traducao = nome + " = " + (yyval).label + ";\n";

		    			addVarMap((yyval).tipo,(yyval).label,nome,(yyval).label);
		    		}
		    	}
		    }
#line 2400 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 1062 "sintatica.y" /* yacc.c:1646  */
    {
		    }
#line 2407 "y.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 1067 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-2]).tipo == "id" && (yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label);

						buscaMapa((yyvsp[0]).label,0);

						if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome((yyvsp[0]).label),
								   tempTipo3  = retornaTipo((yyvsp[0]).label);

							if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id + id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

								(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
								(yyval).label = "NULL";
								(yyval).tipo = tempTipo1;
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

								string temp = geraLabel();
								mudaTipo(tempLabel1,tempTipo3);

								(yyval).label = temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
								(yyval).tipo_traducao =  temp + " " + (yyvsp[-1]).label + " " + tempLabel3;
								(yyval).tipo = tempTipo3;

								addVarMap(tempTipo3,temp,temp,(yyval).traducao);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

								string temp = geraLabel();
								mudaTipo(tempLabel3,tempTipo1);

								(yyval).label = temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
								(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
								(yyval).tipo = tempTipo1;

								addVarMap(tempTipo1,temp,temp,(yyval).traducao);
							}
						}
					}
				}

				else if((yyvsp[-2]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id + term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).label = (yyvsp[0]).traducao + "\n";
							(yyval).tipo = tempTipo1;

						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							(yyval).label = (yyvsp[0]).traducao + "\n"+ temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							(yyval).tipo_traducao =  temp + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).tipo = tempTipo3;

							addVarMap(tempTipo3,temp,temp,(yyval).traducao);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							(yyval).label = (yyvsp[0]).traducao + "\n"+ temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
							(yyval).tipo = tempTipo1;

							addVarMap(tempTipo1,temp,temp,(yyval).traducao);
						}
					}
				}

				else if((yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[0]).label,0);

					if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term + id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).label = (yyvsp[-2]).traducao;
							(yyval).tipo = tempTipo1;
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							(yyval).label =(yyvsp[-2]).traducao + "\n"+ temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
							(yyval).tipo = tempTipo3;

							addVarMap(tempTipo1,temp,temp,(yyval).traducao);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							(yyval).label =(yyvsp[-2]).traducao + "\n"+ temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							(yyval).tipo_traducao =  temp + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).tipo = tempTipo1;

							addVarMap(tempTipo3,temp,temp,(yyval).traducao);
						}
					}
				}

				else{

					string tempTipo1  = retornaTipo((yyvsp[-2]).label),
						   tempLabel3 = retornaNome((yyvsp[0]).label),
						   tempLabel1 = retornaNome((yyvsp[-2]).label),
						   tempTipo3  = retornaTipo((yyvsp[0]).label);

					if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term + term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

						(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao;
						(yyval).tipo = tempTipo1;
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
						(yyval).tipo = tempTipo3;

						addVarMap(tempTipo1,temp,temp,(yyval).traducao);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
						(yyval).tipo = tempTipo1;

						addVarMap(tempTipo1,temp,temp,(yyval).traducao);
					}
				}
			}
#line 2616 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 1273 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-2]).tipo == "id" && (yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label);

						buscaMapa((yyvsp[0]).label,0);

						if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome((yyvsp[0]).label),
								   tempTipo3  = retornaTipo((yyvsp[0]).label);

							if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id * id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

								(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
								(yyval).label = "NULL";
								(yyval).tipo = tempTipo1;
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

								string temp = geraLabel();
								mudaTipo(tempLabel1,tempTipo3);

								(yyval).label = temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
								(yyval).tipo_traducao =  temp + " " + (yyvsp[-1]).label + " " + tempLabel3;
								(yyval).tipo = tempTipo3;

								addVarMap(tempTipo3,temp,temp,(yyval).traducao);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

								string temp = geraLabel();
								mudaTipo(tempLabel3,tempTipo1);

								(yyval).label = temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
								(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
								(yyval).tipo = tempTipo1;

								addVarMap(tempTipo1,temp,temp,(yyval).traducao);
							}
						}
					}
				}

				else if((yyvsp[-2]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id * term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).label =(yyvsp[0]).traducao + "\n\n";
							(yyval).tipo = tempTipo1;
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							(yyval).label = (yyvsp[0]).traducao + "\n\n" + temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							(yyval).tipo_traducao =  temp + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).tipo = tempTipo3;

							addVarMap(tempTipo3,temp,temp,(yyval).traducao);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							(yyval).label = (yyvsp[0]).traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
							(yyval).tipo = tempTipo1;

							addVarMap(tempTipo1,temp,temp,(yyval).traducao);
						}
					}
				}

				else if((yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[0]).label,0);

					if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term * id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao = tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
							(yyval).label = (yyvsp[-2]).traducao + "\n\n";

							(yyval).tipo = tempTipo1;
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							(yyval).label = (yyvsp[-2]).traducao + "\n\n" + temp + " = (" + tempTipo3 + ")" + tempLabel1 + " ;\n\n";
							(yyval).tipo_traducao =  tempLabel3 + (yyvsp[-1]).label + temp;
							(yyval).tipo = tempTipo3;

							addVarMap(tempTipo3,temp,temp,(yyval).tipo_traducao);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							(yyval).label = (yyvsp[-2]).traducao + "\n\n" + temp + " = (" + tempTipo1 + ")"+ tempLabel3 + " ;\n\n";
							(yyval).tipo_traducao =  temp + " " + (yyvsp[-1]).label + " " + tempLabel1;
							(yyval).tipo = tempTipo1;

							addVarMap(tempTipo1,temp,temp,(yyval).tipo_traducao);
						}
					}
				}

				else{

					string tempLabel1 = retornaNome((yyvsp[-2]).label),
						   tempTipo1  = retornaTipo((yyvsp[-2]).label),
						   tempLabel3 = retornaNome((yyvsp[0]).label),
						   tempTipo3  = retornaTipo((yyvsp[0]).label);

					if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term * term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

						(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao;
						(yyval).tipo = tempTipo1;
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
						(yyval).tipo = tempTipo3;

						addVarMap(tempTipo1,temp,temp,(yyval).traducao);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						(yyval).tipo_traducao =  tempLabel1 + (yyvsp[-1]).label + temp;
						(yyval).tipo = tempTipo1;

						addVarMap(tempTipo1,temp,temp,(yyval).traducao);
					}
				}
			}
#line 2825 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 1479 "sintatica.y" /* yacc.c:1646  */
    {//Esse OUTRA_OP permite fazer operacoes aritmeticas de tamanho n, porém eu não to sabendo o que fazer pro cod intermediario sair


			}
#line 2834 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 1484 "sintatica.y" /* yacc.c:1646  */
    {


			}
#line 2843 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 1491 "sintatica.y" /* yacc.c:1646  */
    {
				if((yyvsp[-2]).tipo == "id" && (yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label);

						buscaMapa((yyvsp[0]).label,0);

						if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome((yyvsp[0]).label),
								   tempTipo3  = retornaTipo((yyvsp[0]).label);

							if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id < id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

								(yyval).tipo_traducao = "(" + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";
								(yyval).label = "NULL";

							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

								string temp = geraLabel();
								mudaTipo(tempLabel1,tempTipo3);

								(yyval).label = temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
								(yyval).tipo_traducao = "(" + temp + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";

								addVarMap(tempTipo3,temp,temp,(yyval).traducao);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

								string temp = geraLabel();
								mudaTipo(tempLabel3,tempTipo1);

								(yyval).label = temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
								(yyval).tipo_traducao =  "(" + tempLabel1 + (yyvsp[-1]).label + temp + ")";

								addVarMap(tempTipo1,temp,temp,(yyval).traducao);
							}
						}
					}
				}

				else if((yyvsp[-2]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id > term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).traducao =  "(" + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";
							(yyval).label = (yyvsp[0]).traducao;

						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							(yyval).label = (yyvsp[0]).traducao + "\n" + temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							(yyval).tipo_traducao = "(" + temp + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";


							addVarMap(tempTipo3,temp,temp,(yyval).traducao);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							(yyval).label =  (yyvsp[0]).traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							(yyval).tipo_traducao = "(" + tempLabel1 + (yyvsp[-1]).label + temp + ")";

							addVarMap(tempTipo1,temp,temp,(yyval).traducao);
						}
					}
				}

				else if((yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[0]).label,0);

					if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);
							   cout<< tempLabel1 << endl<< tempTipo1;
						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term > id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao = "(" + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";
							(yyval).label =  (yyvsp[-2]).traducao;

						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							(yyval).label = (yyvsp[-2]).traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							(yyval).tipo_traducao = "(" + tempLabel1 + (yyvsp[-1]).label + temp + ")";

							addVarMap(tempTipo1,temp,temp,(yyval).traducao);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							(yyval).label = (yyvsp[-2]).traducao + "\n" + temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							(yyval).tipo_traducao = "(" + temp + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";

							addVarMap(tempTipo3,temp,temp,(yyval).traducao);
						}
					}
				}
				else{

					string tempLabel1 = retornaNome((yyvsp[-2]).label),
						   tempTipo1  = retornaTipo((yyvsp[-2]).label),
						   tempLabel3 = retornaNome((yyvsp[0]).label),
						   tempTipo3  = retornaTipo((yyvsp[0]).label);

					if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term > term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

						(yyval).tipo_traducao = "(" + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3 + ")";
						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao;
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						(yyval).tipo_traducao = "(" + tempLabel1 + (yyvsp[-1]).label + temp + ")";

						addVarMap(tempTipo1,temp,temp,(yyval).traducao);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						(yyval).label = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						(yyval).tipo_traducao = "(" + tempLabel1 + (yyvsp[-1]).label + temp + ")";

						addVarMap(tempTipo1,temp,temp,(yyval).traducao);
					}
				}
			}
#line 3041 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 1687 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[0]).label,0);

				if(verificaDeclaracao((yyvsp[0]).label) == 1){

					string tempTipo = retornaTipo((yyvsp[0]).label);

					if(tempTipo == "bool"){

						string tempLabel = retornaNome((yyvsp[0]).label),
						tempValor = retornaValor((yyvsp[0]).label);

						if(tempValor == "1"){
							(yyval).label = " = 0;\n\n";
							alteraValor((yyvsp[0]).label,"0");
							(yyval).tipo_traducao = tempLabel + " = 0;\n\n";
						}

						else if(tempValor == "0"){
							(yyval).label = " = 1;\n\n";
							alteraValor((yyvsp[0]).label,"1");
							(yyval).tipo_traducao = tempLabel + " = 1;\n\n";
						}
						(yyval).tipo = tempValor;
						(yyval).traducao = (yyvsp[0]).label;
					}

					else{ // Está tentando negar algo q não é boolean

						erro = "Erro de Semântica na Linha : eu to no OP not" + to_string(linha);
						yyerror(erro);
					}

				}

				else{ // variavel não declarada

						erro = "Erro de Semântica na Linha : eu to no not2" + to_string(linha);
						yyerror(erro);
				}
			}
#line 3088 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 1732 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-2]).tipo == "id" && (yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label);

						buscaMapa((yyvsp[0]).label,0);

						if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome((yyvsp[0]).label),
								   tempTipo3  = retornaTipo((yyvsp[0]).label);

							if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id and id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

								(yyval).tipo_traducao =  tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
							}
						}
					}
				}

				else if((yyvsp[-2]).tipo == "id"){

					buscaMapa((yyvsp[-2]).label,0);

					if(verificaDeclaracao((yyvsp[-2]).label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das 	variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id and term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao = (yyvsp[0]).traducao + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
						}
					}
				}

				else if((yyvsp[0]).tipo == "id"){

					buscaMapa((yyvsp[0]).label,0);

					if(verificaDeclaracao((yyvsp[0]).label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome((yyvsp[-2]).label),
							   tempTipo1  = retornaTipo((yyvsp[-2]).label),
							   tempLabel3 = retornaNome((yyvsp[0]).label),
							   tempTipo3  = retornaTipo((yyvsp[0]).label);

						if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term and id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

							(yyval).tipo_traducao = (yyvsp[-2]).traducao + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
						}
					}
				}

				else{

					string tempLabel1 = retornaNome((yyvsp[-2]).label),
						   tempTipo1  = retornaTipo((yyvsp[-2]).label),
						   tempLabel3 = retornaNome((yyvsp[0]).label),
						   tempTipo3  = retornaTipo((yyvsp[0]).label);

					if ( verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term and term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,(yyvsp[-1]).label,tempTipo3) == 0){// não precisa de cast implicito

						(yyval).tipo_traducao = (yyvsp[-2]).traducao + (yyvsp[0]).traducao + tempLabel1 + " " + (yyvsp[-1]).label + " " + tempLabel3;
					}
				}
			}
#line 3192 "y.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 1834 "sintatica.y" /* yacc.c:1646  */
    {
				if ((yyvsp[-1]).label == "int"){ // Devo criar um temp novo para representar a variavel após o cast ou faço variavel=(int)variavel ?

					buscaMapa((yyvsp[0]).label,0);

					if(verificaDeclaracao((yyvsp[0]).label) == 1){

						mudaTipo((yyvsp[0]).label,(yyvsp[-1]).label);
						string temp = retornaValor((yyvsp[0]).label);
						int temp1 = atoi(temp.c_str());
						temp = to_string(temp1);
						alteraValor((yyvsp[0]).label,temp);

						string tempLabel = retornaNome((yyvsp[0]).label);
						(yyval).traducao = tempLabel + " = (" + (yyvsp[-1]).label + ") " + tempLabel + ";\n\n";
					}

					else if (verificaDeclaracao((yyvsp[0]).label) == 0){

						erro = "Erro de Semântica na Linha : eu to no cast int" + to_string(linha);
						yyerror(erro);
					}
				}

				else if((yyvsp[-1]).label == "float"){ // Devo criar um temp novo para representar a variavel após o cast ou faço variavel=(float)variavel ?

					buscaMapa((yyvsp[0]).label,0);

					if(verificaDeclaracao((yyvsp[0]).label) == 1){

						mudaTipo((yyvsp[0]).label,(yyvsp[-1]).label);
						string temp = retornaValor((yyvsp[0]).label);
						temp = temp + ".0";
						alteraValor((yyvsp[0]).label,temp);

						string tempLabel = retornaNome((yyvsp[0]).label);
						(yyval).traducao = tempLabel + " = (" + (yyvsp[-1]).label + ") " + tempLabel + ";\n\n";
					}

					else if (verificaDeclaracao((yyvsp[0]).label) == 0){

						erro = "Erro de Semântica na Linha : eu to no cast float" + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 3243 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 1883 "sintatica.y" /* yacc.c:1646  */
    {

				buscaMapa((yyvsp[-1]).label,0);

				if((yyvsp[-3]).label == "cin"){

					if(verificaDeclaracao((yyvsp[-1]).label)==1){

						string tempLabel = retornaNome((yyvsp[-1]).label);
						(yyval).traducao = (yyvsp[-3]).traducao + (yyvsp[-1]).traducao + "\t"
						+ "cin >> " + tempLabel + ";\n\n";
					}

					if(verificaDeclaracao((yyvsp[-1]).label)==0){

						erro = "Erro de Semântica na Linha :eu to no cin " + to_string(linha);
						yyerror(erro);
					}
				}
			}
#line 3268 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 1905 "sintatica.y" /* yacc.c:1646  */
    {

				if((yyvsp[-1]).tipo == "NULL"){

					erro = "Erro de Semântica na Linha :eu to no cin " + to_string(linha);
					yyerror(erro);
				}
				else{

					(yyvsp[-1]).label.erase((yyvsp[-1]).label.end() - 3, (yyvsp[-1]).label.end());
					(yyval).traducao = "cout << " + (yyvsp[-1]).label + ";\n\n";
				}
			}
#line 3286 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 1921 "sintatica.y" /* yacc.c:1646  */
    {
				(yyval).label = (yyvsp[-1]).label + " << " + (yyvsp[0]).label;
			}
#line 3294 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 1924 "sintatica.y" /* yacc.c:1646  */
    {

				if(verificaDeclaracao((yyvsp[-1]).label)==1){

						string tempLabel = retornaNome((yyvsp[-1]).label);
						(yyval).label = tempLabel + " << " + (yyvsp[0]).label;						
				}

				else if(verificaDeclaracao((yyvsp[-1]).label)==0){

						erro = "Erro de Semântica na Linha : vARIAVEL NÃO DECLARADA(T) " + to_string(linha);
						yyerror(erro);
				}
			}
#line 3313 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 1939 "sintatica.y" /* yacc.c:1646  */
    {

				(yyval).tipo = "NULL";
			}
#line 3322 "y.tab.c" /* yacc.c:1646  */
    break;


#line 3326 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1944 "sintatica.y" /* yacc.c:1906  */

#include "lex.yy.c"

int yyparse();

int main( int argc, char* argv[] )
{
	preencheMapCast();
	yyparse();
	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}

string geraLabel(){
	string temp;
	numero++;
	temp = "temp" + to_string(numero);
	return temp;
}

void preencheMapCast(){
	FILE* textFile = fopen("mapa_cast.txt", "r");
	char op1[20] = "";
	char op2[20] = "";
	char operador[3] = "";
	char opfinal[20] = "";
	int retorno;
	string id;
	while(fscanf(textFile, "%s\t%s\t%s\t%s\t%d\n",op1,operador,op2,opfinal,&retorno)){
		cast Cast = {opfinal,retorno};
		id = geraId(op1,operador,op2);
		mapCast[id] = Cast;
		if(feof(textFile)) {
				break;
		}
	}
	fclose(textFile);
}

string geraId(string tipo1, string op, string tipo2 ){
	return tipo1 + "_" + op + "_" + tipo2;
}

int verificaCast(string tipo1, string op, string tipo2 ){
	string id = geraId(tipo1,op,tipo2);
	int aux = mapCast[id].retorno;
	return aux;
}

void addVarMap(string tipo,string id,string nome,string valor){
	variavel vari = {tipo,nome,valor,""};
	mapVar[id] = vari;
	pilhaVar[pilhaPos] = mapVar;
}

void setTamString(string id, string tam){
	mapVar[id].tam = tam;
	pilhaVar[pilhaPos] = mapVar;

}
int verificaDeclaracao(string id){
	if(mapVar.find(id) != mapVar.end()){//achou
		return 1;
	}
	return 0;
}

string retornaNome(string id){
	return mapVar[id].nome;
}

string retornaTipo(string id){
	return mapVar[id].tipo;
}

string retornaValor(string id){
	return mapVar[id].valor;
}

void mudaTipo(string id, string tipo){
	mapVar[id].tipo = tipo;
	pilhaVar[pilhaPos] = mapVar;
}

void empilhaNovoMapa(){
	map<string,variavel> novoMapa;
	pilhaVar.push_back(novoMapa);
	mapVar = novoMapa;
	pilhaPos++;
}

void alteraValor(string id, string valor){
	mapVar[id].valor = valor;
	pilhaVar[pilhaPos] = mapVar;
	cout << "ola alterei o valor da : " << id << " " << mapVar[id].valor << endl;
}

// essa funcao altera o mapVar q esta sendo utilizado DEVE SER CHAMADA ANTES DA VERIFICADECLARACAO
void buscaMapa(string id,int declaracao){

	pilhaPos = pilhaVar.size() - 1; // pego topo da pilhaVar, sendo pilhaPos uma variavel global
	int existeVar = 0;

	if(declaracao == 1){//se eh uma declaracao, preciso verificar no mapa atual se a variavel nao foi declarada antes
		mapVar = pilhaVar[pilhaPos];
		existeVar = verificaDeclaracao(id);
		if (existeVar == 1){
			erro = "Erro de declaração na linha "+to_string(linha) +" a variavel: '" + id + "' já foi previamente declarada neste bloco.";
			yyerror(erro);
		}

	}else{

		for (pilhaPos; pilhaPos > -1; pilhaPos--){

			mapVar = pilhaVar[pilhaPos];
			existeVar = verificaDeclaracao(id);

			if (existeVar == 1){
				break;
			}

		}

	}

	if (existeVar == 0){//nao encontrou a variavel retorna o mapa do topo da pilha

		pilhaPos = pilhaVar.size() - 1;
		mapVar = pilhaVar[pilhaPos];

	}
}

string declara_variaveis_temp(mapaVar map, int flag){
   	string s = "";

	for (mapaVar::iterator it = map.begin(); it!=map.end(); ++it) {
		if(flag == 0){
			if(it->second.tipo == ""){
				erro = "Erro: Não é possivel declarar uma variavel do tipo qualquer no escopo global.";
				yyerror(erro);
				break;
			}
		}
		if(flag == 1){
			if((it->second.tipo == "") && (it->second.valor == "")){
				erro = "Erro: Não é possivel declarar uma variavel do tipo qualquer sem atribuir um valor posteriormente.";
				yyerror(erro);
				break;
			}
		}
		if(it->second.tipo == "string"){

			s += "char " + it->second.nome + "[" + it->second.tam + "] ;\n";
			continue;
		}
		if(it->second.nome == ""){
			continue;
		}
		if(it->second.tipo == "bool" || it->second.tipo == "boolean"){
			s += "int " + it->second.nome + ";\n";
			continue;
		}
		s += it->second.tipo + ' ' + it->second.nome + ";\n";

	}
    return s;
}
