%{
#include <iostream>
#include <string>
#include <sstream>
#include <stdio.h>

#define YYSTYPE atributos

using namespace std;

/* Variavel estatica para enumerar os temps que vão ser nome das variaveis começa em -1 para se ter o temp0 */

int static numero = -1;

struct atributos
{
	string label;
	string traducao;
};

/* Função para  gerar nomes das variaveis */

string geradora(){

	string var;
	char buffer [50];

  	numero++;
    sprintf (buffer, "temp%d",numero);
    var = buffer;

	return var;
}

int yylex(void);
void yyerror(string);
%}

%token TK_INT 
%token TK_FLOAT
%token TK_BOOL
%token TK_CHAR

%token TK_MAIN TK_ID TK_TIPO_INT
%token TK_FIM TK_ERROR

%start S

/* Ordem de procedencia dos sinais. OBS: Não tenho certeza da parte dos parenteses */

%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador FOCA*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.traducao << "\treturn 0;\n}" << endl; 
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO COMANDOS
			|
			;

COMANDO 	: EXPRESSAO ';'
			;

/* Operacoes aritmeticas sem () isso aqui é baseado na calculadora*/
EXPRESSAO	: EXPRESSAO '+' TERMO { $$ = $1 + $3; }
			| EXPRESSAO '-' TERMO { $$ = $1 - $3; }
			| EXPRESSAO '*' TERMO { $$ = $1 * $3; }
			| EXPRESSAO '/' TERMO { $$ = $1 / $3; }
			| TERMO { $$ = $1; }
			;

/* Retorno de inteiros e floats */
TERMO		: TK_INT   { $$ = $1; }
			| TK_FLOAT { $$ = $1; }
			;

%%

#include "lex.yy.c"

int yyparse();

int main( int argc, char* argv[] )
{
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				


