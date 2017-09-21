%{
#include <iostream>
#include <string>
#include <sstream>
#include <stdio.h>

#define YYSTYPE atributos

using namespace std;

int static numero = -1;

struct atributos
{
	string label;
	string traducao;
};

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

%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador ONE*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.traducao << "\treturn 0;\n}" << endl; 
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

TERMO		: TK_INT   { $$ = $1; }
			| TK_FLOAT { $$ = $1; }
			;
EXPRESSAO	: EXPRESSAO '+' TERMO { $$ = $1 + $3; }
			| EXPRESSAO '-' TERMO { $$ = $1 - $3; }
			| EXPRESSAO '*' TERMO { $$ = $1 * $3; }
			| EXPRESSAO '/' TERMO { $$ = $1 / $3; }
			| TERMO { $$ = $1; }
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


