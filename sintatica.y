%{
#include <iostream>
#include <string>
#include <sstream>
#include <fstream>
#include <stdio.h>
#include <map>

#define YYSTYPE atributos

using namespace std;

struct atributos
{
	string label;
	string traducao;
	string tipo;
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
};

typedef map<string,cast> mapaCast;
typedef map<string,variavel> mapaVar;

int linha = 1;
string erro;
static int numero = -1;
static mapaCast mapCast;
static mapaVar mapVar;

int yylex(void);
void yyerror(string);
string geraLabel();
string geraId(string,string,string);
void preencheMapCast();
int verificaCast(string,string,string);
string	intToString(int);
void addVarMap(string,string,string);
string retornaNome(string nome);
string retornaTipo(string nome);
void mudaTipo(string,string);
int verificaDeclaracao(string);


%}

%token TK_INT  TK_REAL TK_BOOLEAN TK_CHAR TK_ID

%token TK_MAIN TK_TIPO_INT TK_TIPO_BOOLEAN TK_TIPO_REAL TK_TIPO_CHAR TK_TIPO_ID

%token TK_RESTO TK_MENOR TK_MAIOR TK_IGUAL TK_DIFERENTE TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_AND TK_OR TK_NOT

%token TK_ATRIBUICAO TK_CAST_INT TK_CAST_FLOAT TK_CIN TK_COUT 

%token TK_IF TK_WHILE TK_FOR TK_ELSE TK_ELSE_IF TK_DO TK_FIM_IF TK_FIM_FOR TK_FIM_WHILE TK_FIM_ELSE_IF TK_FIM_ELSE

%token TK_FIM TK_ERROR


%start S

%left '+' '-'
%left '*' '/' TK_RESTO
%left TK_MENOR TK_MAIOR TK_IGUAL TK_MENOR_IGUAL TK_MAIOR_IGUAL
%left TK_OR
%left TK_AND
%left TK_NOT

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador Uma Linguagem Qualquer*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.traducao << "\treturn 0;\n}" << endl;
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO COMANDOS
			{
				$$.traducao = $1.traducao + $2.traducao;
			}
			|
			;

COMANDO 	: E ';'
			;

E 			: '('E')'
			{
				$$.label = "(" + $2.label +")";
				$$.traducao= $2.traducao;

			}
			| DECLARA
			| OP_ARIT
			| OP_LOGIC
			| OP_REL
			| CAST
			| TERM
			| CIN
			| COUT
			;
DECLARA		: TIPO_BOOL
			| TIPO_CHAR
			| TIPO_INT
			| TIPO_REAL
			| TIPO_ID
			;

TIPO_INT    : TK_TIPO_INT TK_ID TK_ATRIBUICAO TK_INT
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\t" + $4.tipo + " " + $$.label + " = " + $4.label + ";\n\n";

				addVarMap($4.tipo,$2.label,$$.label);
		    }
		    | TK_ID TK_ATRIBUICAO TK_INT
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\t" + $3.tipo + " " + $$.label + " = " + $3.label + ";\n\n";

				addVarMap($3.tipo,$1.label,$$.label);
		    }
		    | TK_TIPO_INT TK_ID
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\tint " + $$.label + ";\n\n";

				addVarMap("int",$2.label,$$.label);
		    }


			;
TIPO_REAL    : TK_TIPO_REAL TK_ID TK_ATRIBUICAO TK_REAL
		    {
		    	$$.label = geraLabel();
				$$.traducao = "\t" + $4.tipo + " " + $$.label + " = " + $4.label + ";\n\n";

				addVarMap($4.tipo,$2.label,$$.label);
		    }
		    | TK_ID TK_ATRIBUICAO TK_REAL
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\t" + $3.tipo + " " + $$.label + " = " + $3.label + ";\n\n";

				addVarMap($3.tipo,$1.label,$$.label);
		    }
		    | TK_TIPO_REAL TK_ID
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\tfloat " + $$.label + ";\n\n";

				addVarMap("float",$2.label,$$.label);
		    }
			;
TIPO_CHAR    : TK_TIPO_CHAR TK_ID TK_ATRIBUICAO TK_CHAR
		    {
		    	$$.label = geraLabel();
				$$.traducao = "\t" + $4.tipo + " " + $$.label + " = " + $4.label + ";\n\n";

				addVarMap($4.tipo,$2.label,$$.label);
		    }
		    | TK_ID TK_ATRIBUICAO TK_CHAR
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\t" + $3.tipo + " " + $$.label + " = " + $3.label + ";\n\n";

				addVarMap($3.tipo,$1.label,$$.label);
		    }
		    | TK_TIPO_CHAR TK_ID
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\tchar " + $$.label + ";\n\n";

				addVarMap("char",$2.label,$$.label);
		    }
			;
TIPO_BOOL    : TK_TIPO_BOOLEAN TK_ID TK_ATRIBUICAO TK_BOOLEAN
		    {
		    	$$.label = geraLabel();
				$$.traducao = "\t" + $4.tipo + " " + $$.label + " = " + $4.label + ";\n\n";

				addVarMap($4.tipo,$2.label,$$.label);
		    }
		    | TK_ID TK_ATRIBUICAO TK_BOOLEAN
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\t" + $3.tipo + " " + $$.label + " = " + $3.label + ";\n\n";

				addVarMap($3.tipo,$1.label,$$.label);
		    }
			| TK_TIPO_BOOLEAN TK_ID
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\tboolean " + $$.label + ";\n\n";

				addVarMap("boolean",$2.label,$$.label);
		    }
			;
TIPO_ID    	: TK_TIPO_ID TK_ID TK_ATRIBUICAO TK_ID
		    {
		    	$$.label = geraLabel();
				$$.traducao = "\t" + $4.tipo + " " + $$.label + " = " + $4.label + ";\n\n";

				addVarMap($4.tipo,$2.label,$$.label);
		    }
		    | TK_ID TK_ATRIBUICAO TK_ID
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\t" + $3.tipo + " " + $$.label + " = " + $3.label + ";\n\n";

				addVarMap($3.tipo,$1.label,$$.label);
		    }
		    | TK_TIPO_ID TK_ID
		    {
		    	$$.label = geraLabel();

				$$.traducao = "\tid " + $$.label + ";\n\n";

				addVarMap("id",$2.label,$$.label);
		    }
			;

OP_ARIT		: ADD
			| SUB
			| MULT
			| DIV
			| RESTO

ADD			: E '+' E
			{
				if(verificaCast($1.tipo,"+",$3.tipo)==-1){
					erro = "Erro de Semântica na Linha :  " + to_string(linha);
					yyerror(erro);
				}

				if(verificaCast($1.tipo,"+",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " + " + $3.label +" ;\n\n";
				}

				if(verificaCast($1.tipo,"+",$3.tipo)== 1 ){
					$$.tipo = $1.tipo = $3.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " + " + $3.label +" ;\n\n";

				}

				if(verificaCast($1.tipo,"+",$3.tipo)== 2 ){
					$$.tipo = $3.tipo = $1.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " + " + $$.label +" ;\n\n";
				}
			}

			| TK_ID '+' E
			{
				if(verificaDeclaracao($1.label)==1){
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					$$.label = geraLabel();

					if ( verificaCast(tempTipo,"+",$3.tipo) == -1 ){
						erro = "Erro de Semântica na Linha : " + to_string(linha);
						yyerror(erro);
					}

					if ( verificaCast(tempTipo,"+",$3.tipo) == 0 ){
						$$.tipo = tempTipo;
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " + " + $3.label +" ;\n\n";
					}
					if ( verificaCast(tempTipo,"+",$3.tipo) == 1 ){
					$$.tipo = tempTipo = $3.tipo;
					mudaTipo($1.label,$3.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " + " + $3.label +" ;\n\n";
					}
					if ( verificaCast(tempTipo,"+",$3.tipo) == 2 ){
						$$.tipo = $3.tipo = tempTipo;
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " + " + $$.label +" ;\n\n";
					}
				}
				if(verificaDeclaracao($1.label)==0 )
				{
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}
			}

			| E '+' TK_ID
			{
				if(verificaDeclaracao($3.label)==1 ){
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);
				$$.label = geraLabel();

				if ( verificaCast($1.tipo,"+",tempTipo) == -1 ){
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}

				if ( verificaCast($1.tipo,"+",tempTipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " + " + $1.label +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"+",tempTipo) == 1 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " + " + tempLabel +" ;\n\n";
					}
					if ( verificaCast($1.tipo,"+",tempTipo) == 2 ){
						$$.tipo = tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " + " + $$.label +" ;\n\n";
					}
				}
				if(verificaDeclaracao($3.label)==0)
				{
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID '+' TK_ID

			{	
				
				if(verificaDeclaracao($1.label)==1 && verificaDeclaracao($3.label)==1 ){
					string tempLabel  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					$$.label = geraLabel();

					if ( verificaCast(tempTipo,"+",tempTipo2) == -1 ){
						erro = "Erro de Semântica na Linha : " + to_string(linha);
						yyerror(erro);
					}

					if ( verificaCast(tempTipo,"+",tempTipo2) == 0 ){
						$$.tipo = tempTipo;
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " + " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"+",tempTipo2) == 1 ){
						$$.tipo = tempTipo = tempTipo2;
						mudaTipo(tempLabel,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " + " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"+",tempTipo2) == 2 ){
						$$.tipo = tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " + " + $$.label +" ;\n\n";
					}
				}
				if(verificaDeclaracao($1.label)==0 || verificaDeclaracao($3.label)==0)
				{
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}			
			}
			;

SUB			: E '-' E
			{
				if(verificaCast($1.tipo,"-",$3.tipo)==-1){
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
					}

				if(verificaCast($1.tipo,"-",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " - " + $3.label +" ;\n\n";
				}

				if(verificaCast($1.tipo,"-",$3.tipo)== 1 ){
					$$.tipo = $1.tipo = $3.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " - " + $3.label +" ;\n\n";

				}

				if(verificaCast($1.tipo,"-",$3.tipo)== 2 ){
					$$.tipo = $3.tipo = $1.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " - " + $$.label +" ;\n\n";
				}
			}

			| TK_ID '-' E
			{
				if(verificaDeclaracao($1.label)==1)
				{
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					$$.label = geraLabel();

					if ( verificaCast(tempTipo,"-",$3.tipo) == -1 ){
						erro = "Erro de Semântica na Linha : " + to_string(linha);
						yyerror(erro);
						}

					if ( verificaCast(tempTipo,"-",$3.tipo) == 0 ){
						$$.tipo = tempTipo;
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " - " + $3.label +" ;\n\n";
					}
					if ( verificaCast(tempTipo,"-",$3.tipo) == 1 ){
						$$.tipo = tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " - " + $3.label +" ;\n\n";
					}
					if ( verificaCast(tempTipo,"-",$3.tipo) == 2 ){
						$$.tipo = $3.tipo = tempTipo;
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " - " + $$.label +" ;\n\n";
					}
				}
				if(verificaDeclaracao($1.label)==0 )
				{
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}
			}
			| E '-' TK_ID
			{
				if(verificaDeclaracao($3.label) == 1)
				{
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					$$.label = geraLabel();

					if ( verificaCast($1.tipo,"-",tempTipo) == -1 ){
						erro = "Erro de Semântica na Linha : " + to_string(linha);
						yyerror(erro);
					}

					if ( verificaCast($1.tipo,"-",tempTipo) == 0 ){
						$$.tipo = tempTipo;
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " - " + $1.label +" ;\n\n";
					}
					if ( verificaCast($1.tipo,"-",tempTipo) == 1 ){
						$$.tipo = $3.tipo = tempTipo;
						string tempLabel0 = geraLabel();

						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " - " + tempLabel +" ;\n\n";
					}
					if ( verificaCast($1.tipo,"-",tempTipo) == 2 ){
						$$.tipo = tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " - " + $$.label +" ;\n\n";
					}
				}
				if(verificaDeclaracao($3.label) == 0)
				{
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID '-' TK_ID

			{
				if(verificaDeclaracao($1.label) == 1 && verificaDeclaracao($3.label) == 1)
				{
					string tempLabel  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					$$.label = geraLabel();

					if ( verificaCast(tempTipo,"-",tempTipo2) == -1 )
					{
						erro = "Erro de Semântica na Linha : " + to_string(linha);
						yyerror(erro);
					}
					
					if ( verificaCast(tempTipo,"-",tempTipo2) == 0 ){
						$$.tipo = tempTipo;
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " - " + tempLabel2 +" ;\n\n";
					}
					
					if ( verificaCast(tempTipo,"-",tempTipo2) == 1 ){
						$$.tipo = tempTipo = tempTipo2;
						mudaTipo(tempLabel,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " - " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"-",tempTipo2) == 2 ){
					$$.tipo = tempTipo2 = tempTipo;
					mudaTipo(tempLabel2,tempTipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " - " + $$.label +" ;\n\n";
					}
				}
				if(verificaDeclaracao($1.label)==0 && verificaDeclaracao($3.label)==0)
				{
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}

			}
			;

MULT		: E '*' E
			{
				if(verificaCast($1.tipo,"*",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"*",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " * " + $3.label +" ;\n\n";
				}

				if(verificaCast($1.tipo,"*",$3.tipo)== 1 ){
					$$.tipo = $1.tipo = $3.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " * " + $3.label +" ;\n\n";

				}

				if(verificaCast($1.tipo,"*",$3.tipo)== 2 ){
					$$.tipo = $3.tipo = $1.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " * " + $$.label +" ;\n\n";
				}
			}

			| TK_ID '*' E
			{
				string tempTipo = retornaTipo($1.label);
				string tempLabel = retornaNome($1.label);
				$$.label = geraLabel();

				if ( verificaCast(tempTipo,"*",$3.tipo) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast(tempTipo,"*",$3.tipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " * " + $3.label +" ;\n\n";
				}
				if ( verificaCast(tempTipo,"*",$3.tipo) == 1 ){
					$$.tipo = tempTipo = $3.tipo;
					mudaTipo($1.label,$3.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " * " + $3.label +" ;\n\n";
				}
				if ( verificaCast(tempTipo,"*",$3.tipo) == 2 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " * " + $$.label +" ;\n\n";
				}
			}

			| E '*' TK_ID
			{
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);
				$$.label = geraLabel();

				if ( verificaCast($1.tipo,"*",tempTipo) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast($1.tipo,"*",tempTipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " * " + $1.label +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"*",tempTipo) == 1 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " * " + tempLabel +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"*",tempTipo) == 2 ){
					$$.tipo = tempTipo = $1.tipo;
					mudaTipo($3.label,$1.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " * " + $$.label +" ;\n\n";
				}
			}

			| TK_ID '*' TK_ID

			{
				string tempLabel  = retornaNome($1.label);
				string tempLabel2 = retornaNome($3.label);
				string tempTipo   = retornaTipo($1.label);
				string tempTipo2  = retornaTipo($3.label);
				$$.label = geraLabel();

				if ( verificaCast(tempTipo,"*",tempTipo2) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast(tempTipo,"*",tempTipo2) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " * " + tempLabel2 +" ;\n\n";
				}

				if ( verificaCast(tempTipo,"*",tempTipo2) == 1 ){
					$$.tipo = tempTipo = tempTipo2;
					mudaTipo(tempLabel,tempTipo2);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " * " + tempLabel2 +" ;\n\n";
				}

				if ( verificaCast(tempTipo,"*",tempTipo2) == 2 ){
					$$.tipo = tempTipo2 = tempTipo;
					mudaTipo(tempLabel2,tempTipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " * " + $$.label +" ;\n\n";
				}

			}
			;

DIV			: E '/' E
			{
				if(verificaCast($1.tipo,"/",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"/",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " / " + $3.label +" ;\n\n";
				}

				if(verificaCast($1.tipo,"/",$3.tipo)== 1 ){
					$$.tipo = $1.tipo = $3.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " / " + $3.label +" ;\n\n";

				}

				if(verificaCast($1.tipo,"/",$3.tipo)== 2 ){
					$$.tipo = $3.tipo = $1.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " / " + $$.label +" ;\n\n";
				}
			}

			| TK_ID '/' E
			{
				string tempTipo = retornaTipo($1.label);
				string tempLabel = retornaNome($1.label);
				$$.label = geraLabel();

				if ( verificaCast(tempTipo,"/",$3.tipo) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast(tempTipo,"/",$3.tipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " / " + $3.label +" ;\n\n";
				}
				if ( verificaCast(tempTipo,"/",$3.tipo) == 1 ){
					$$.tipo = tempTipo = $3.tipo;
					mudaTipo($1.label,$3.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " / " + $3.label +" ;\n\n";
				}
				if ( verificaCast(tempTipo,"/",$3.tipo) == 2 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " / " + $$.label +" ;\n\n";
				}
			}

			| E '/' TK_ID
			{
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);
				$$.label = geraLabel();

				if ( verificaCast($1.tipo,"/",tempTipo) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast($1.tipo,"/",tempTipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " / " + $1.label +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"/",tempTipo) == 1 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " / " + tempLabel +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"/",tempTipo) == 2 ){
					$$.tipo = tempTipo = $1.tipo;
					mudaTipo($3.label,$1.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " / " + $$.label +" ;\n\n";
				}
			}

			| TK_ID '/' TK_ID

			{
				string tempLabel  = retornaNome($1.label);
				string tempLabel2 = retornaNome($3.label);
				string tempTipo   = retornaTipo($1.label);
				string tempTipo2  = retornaTipo($3.label);
				$$.label = geraLabel();

				if ( verificaCast(tempTipo,"/",tempTipo2) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast(tempTipo,"+",tempTipo2) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " / " + tempLabel2 +" ;\n\n";
				}

				if ( verificaCast(tempTipo,"/",tempTipo2) == 1 ){
					$$.tipo = tempTipo = tempTipo2;
					mudaTipo(tempLabel,tempTipo2);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " / " + tempLabel2 +" ;\n\n";
				}

				if ( verificaCast(tempTipo,"/",tempTipo2) == 2 ){
					$$.tipo = tempTipo2 = tempTipo;
					mudaTipo(tempLabel2,tempTipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " / " + $$.label +" ;\n\n";
				}

			}
			;

RESTO		: E TK_RESTO E
			{
				if(verificaCast($1.tipo,"%",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"%",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " % " + $3.label +" ;\n\n";
				}

				if(verificaCast($1.tipo,"%",$3.tipo)== 1 ){
					$$.tipo = $1.tipo = $3.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " % " + $3.label +" ;\n\n";

				}

				if(verificaCast($1.tipo,"%",$3.tipo)== 2 ){
					$$.tipo = $3.tipo = $1.tipo;
					$$.label = geraLabel();
					string tempLabel = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " % " + $$.label +" ;\n\n";
				}
			}

			| TK_ID TK_RESTO E
			{
				string tempTipo = retornaTipo($1.label);
				string tempLabel = retornaNome($1.label);
				$$.label = geraLabel();

				if ( verificaCast(tempTipo,"%",$3.tipo) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast(tempTipo,"%",$3.tipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " % " + $3.label +" ;\n\n";
				}
				if ( verificaCast(tempTipo,"%",$3.tipo) == 1 ){
					$$.tipo = tempTipo = $3.tipo;
					mudaTipo($1.label,$3.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " % " + $3.label +" ;\n\n";
				}
				if ( verificaCast(tempTipo,"%",$3.tipo) == 2 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " % " + $$.label +" ;\n\n";
				}
			}

			| E TK_RESTO TK_ID
			{
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);
				$$.label = geraLabel();

				if ( verificaCast($1.tipo,"%",tempTipo) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast($1.tipo,"%",tempTipo) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " % " + $1.label +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"%",tempTipo) == 1 ){
					$$.tipo = $3.tipo = tempTipo;
					string tempLabel0 = geraLabel();

					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " % " + tempLabel +" ;\n\n";
				}
				if ( verificaCast($1.tipo,"%",tempTipo) == 2 ){
					$$.tipo = tempTipo = $1.tipo;
					mudaTipo($3.label,$1.tipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " % " + $$.label +" ;\n\n";
				}
			}

			| TK_ID TK_RESTO TK_ID

			{
				string tempLabel  = retornaNome($1.label);
				string tempLabel2 = retornaNome($3.label);
				string tempTipo   = retornaTipo($1.label);
				string tempTipo2  = retornaTipo($3.label);
				$$.label = geraLabel();

				if ( verificaCast(tempTipo,"%",tempTipo2) == -1 )
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if ( verificaCast(tempTipo,"%",tempTipo2) == 0 ){
					$$.tipo = tempTipo;
					$$.traducao = $3.traducao + $1.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " % " + tempLabel2 +" ;\n\n";
				}

				if ( verificaCast(tempTipo,"%",tempTipo2) == 1 ){
					$$.tipo = tempTipo = tempTipo2;
					mudaTipo(tempLabel,tempTipo2);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " % " + tempLabel2 +" ;\n\n";
				}

				if ( verificaCast(tempTipo,"%",tempTipo2) == 2 ){
					$$.tipo = tempTipo2 = tempTipo;
					mudaTipo(tempLabel2,tempTipo);
					string tempLabel0 = geraLabel();

					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
					$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " % " + $$.label +" ;\n\n";
				}

			}
			;

OP_LOGIC	: NOT
			| AND
			| OR
			;

NOT 		: TK_NOT TK_BOOLEAN
			{
				$$.label = geraLabel();
				string templabel = geraLabel();
				$$.traducao = $1.traducao + $2.traducao + "\t" +
				$2.tipo + " " + $$.label + " = " + " " + $2.label +" ;\n\n\t" +
				$2.tipo + " " + templabel + " = " + " not " + $$.label +" ;\n\n";
			}
			;

AND 		: E TK_AND E
			{

				if(verificaCast($1.tipo,"and",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"and",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " and " + $3.label +" ;\n\n";
				}
			}
			| TK_ID TK_AND E
			{
				string tempTipo = retornaTipo($1.label);
				string tempLabel = retornaNome($1.label);

				if(verificaCast(tempTipo,"and",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast(tempTipo,"and",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " and " + $3.label +" ;\n\n";
				}
			}
			| E TK_AND TK_ID
			{
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);

				if(verificaCast($1.tipo,"and",tempTipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"and",tempTipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " and " + tempLabel +" ;\n\n";
				}
			}
			| TK_ID TK_AND TK_ID
			{
				string tempTipo1 = retornaTipo($1.label);
				string tempLabel1 = retornaNome($1.label);
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);

				if(verificaCast(tempTipo1,"and",tempTipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast(tempTipo1,"and",tempTipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel1 + " and " + tempLabel +" ;\n\n";
				}

			}
			;

OR			: E TK_OR E
			{

				if(verificaCast($1.tipo,"or",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"or",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " or " + $3.label +" ;\n\n";
				}
			}
			| TK_ID TK_OR E
			{
				string tempTipo = retornaTipo($1.label);
				string tempLabel = retornaNome($1.label);

				if(verificaCast(tempTipo,"or",$3.tipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast(tempTipo,"or",$3.tipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel + " or " + $3.label +" ;\n\n";
				}
			}
			| E TK_OR TK_ID
			{
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);

				if(verificaCast($1.tipo,"or",tempTipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast($1.tipo,"or",tempTipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + $1.label + " or " + tempLabel +" ;\n\n";
				}
			}
			| TK_ID TK_OR TK_ID
			{
				string tempTipo1 = retornaTipo($1.label);
				string tempLabel1 = retornaNome($1.label);
				string tempTipo = retornaTipo($3.label);
				string tempLabel = retornaNome($3.label);

				if(verificaCast(tempTipo1,"or",tempTipo)==-1)
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

				if(verificaCast(tempTipo1,"or",tempTipo)== 0 ){
					$$.label = geraLabel();
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.tipo + " " + $$.label + " = " + tempLabel1 + " or " + tempLabel +" ;\n\n";
				}

			}
			;

TERM		: TK_INT
		    {
		    	$$.label = geraLabel();
					$$.traducao = "\t" + $$.tipo + " " + $$.label + " = " + $1.label + ";\n\n";
		    }

			| '-' TK_INT /*regra para ler inteiros negativos*/
			{
				$$.label = geraLabel();
				$$.tipo = $2.tipo;
				$$.traducao = "\t" + $$.tipo + " " + $$.label + " = " + " - " + $2.label + ";\n\n";
			}
			| TK_REAL
		    {
		    	$$.label = geraLabel();
					$$.traducao = "\t" + $$.tipo + " " + $$.label + " = " + $1.label + ";\n\n";
		    }
				| '-' TK_REAL /*regra para ler reais negativos */
				{
					$$.label = geraLabel();
					$$.tipo = $2.tipo;
					$$.traducao = "\t" + $$.tipo + " " + $$.label + " = " + " - " + $2.label + ";\n\n";
				}

			| TK_ID
		    {
		    }

			| TK_CHAR
		    {
		    	$$.label = geraLabel();
					$$.traducao = "\t" + $$.tipo + " " + $$.label + " = " + $1.label + ";\n\n";
		    }

			| TK_BOOLEAN
		    {
		    	$$.label = geraLabel();
					$$.traducao = "\t" + $$.tipo + " " + $$.label + " = " + $1.label + ";\n\n";
		    }
			;

OP_REL 		: MENOR
			| MAIOR
			| IGUAL
			| MENOR_IGUAL
			| MAIOR_IGUAL
			| DIFERENTE
			;

MENOR 		: E TK_MENOR E
			{
				$$.tipo = "boolean";
				$$.label = geraLabel();

				if($1.tipo == "id" && $3.tipo == "id"){

					string tempLabel1  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					
					
					if ( verificaCast(tempTipo,"<",tempTipo2) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"<",tempTipo2) == 0 ){
						
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel1 + " < " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"<",tempTipo2) == 1 ){
						
						
						tempTipo = tempTipo2;
						mudaTipo(tempLabel1,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel1 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " < " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"<",tempTipo2) == 2 ){
						
						
						tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel1 + " < " + $$.label +" ;\n\n";
					}
				}

				else if($1.tipo == "id"){
				
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					

					if ( verificaCast(tempTipo,"<",$3.tipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"<",$3.tipo) == 0 ){
				
						
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " < " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"<",$3.tipo) == 1 ){
				
						tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " < " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"<",$3.tipo) == 2 ){
				
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " < " + $$.label +" ;\n\n";
					}
				}
			
				else if($3.tipo == "id"){
		
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					
		
					if ( verificaCast($1.tipo,"<",tempTipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
		
					if ( verificaCast($1.tipo,"<",tempTipo) == 0 ){
			
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " < " + $1.label +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"<",tempTipo) == 1 ){
			
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
			
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " < " + tempLabel +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"<",tempTipo) == 2 ){
			
						tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();
			
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " < " + $$.label +" ;\n\n";
					}
				}


				else
					if(verificaCast($1.tipo,"<",$3.tipo)==-1)
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if(verificaCast($1.tipo,"<",$3.tipo)== 0 ){	
							
							$$.traducao = $1.traducao + $3.traducao + "\t" +
							$$.tipo + " " + $$.label + " = " + $1.label + " < " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"<",$3.tipo)== 1 ){
						$$.tipo = $1.tipo = $3.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " < " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"<",$3.tipo)== 2 ){
						$$.tipo = $3.tipo = $1.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " < " + $$.label +" ;\n\n";
					}
			
			}
			;

MAIOR 		: E TK_MAIOR E
			{

				$$.tipo = "boolean";
				$$.label = geraLabel();

				if($1.tipo == "id" && $3.tipo == "id"){

					string tempLabel1  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					
					
					if ( verificaCast(tempTipo,">",tempTipo2) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,">",tempTipo2) == 0 ){
						
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel1 + " > " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,">",tempTipo2) == 1 ){
						
						
						tempTipo = tempTipo2;
						mudaTipo(tempLabel1,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel1 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " > " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,">",tempTipo2) == 2 ){
						
						
						tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel1 + " > " + $$.label +" ;\n\n";
					}
				}

				else if($1.tipo == "id"){
				
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					

					if ( verificaCast(tempTipo,">",$3.tipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,">",$3.tipo) == 0 ){
				
						
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " > " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,">",$3.tipo) == 1 ){
				
						tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " > " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,">",$3.tipo) == 2 ){
				
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " > " + $$.label +" ;\n\n";
					}
				}
			
				else if($3.tipo == "id"){
		
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					
		
					if ( verificaCast($1.tipo,">",tempTipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
		
					if ( verificaCast($1.tipo,">",tempTipo) == 0 ){
			
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " > " + $1.label +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,">",tempTipo) == 1 ){
			
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
			
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " > " + tempLabel +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,">",tempTipo) == 2 ){
			
						tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();
			
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " > " + $$.label +" ;\n\n";
					}
				}
		
				else
					if(verificaCast($1.tipo,">",$3.tipo)==-1)
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if(verificaCast($1.tipo,"<",$3.tipo)== 0 ){	
							
							$$.traducao = $1.traducao + $3.traducao + "\t" +
							$$.tipo + " " + $$.label + " = " + $1.label + " > " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,">",$3.tipo)== 1 ){
						$$.tipo = $1.tipo = $3.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " > " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,">",$3.tipo)== 2 ){
						$$.tipo = $3.tipo = $1.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " > " + $$.label +" ;\n\n";
					}

			}

			;

IGUAL 		: E TK_IGUAL E
			{
				$$.tipo = "boolean";
				$$.label = geraLabel();
				
				if($1.tipo == "id" && $3.tipo == "id"){

					string tempLabel1  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					
					
					if ( verificaCast(tempTipo,"==",tempTipo2) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"==",tempTipo2) == 0 ){
						
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel1 + " == " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"==",tempTipo2) == 1 ){
						
						
						tempTipo = tempTipo2;
						mudaTipo(tempLabel1,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel1 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " == " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"==",tempTipo2) == 2 ){
						
						
						tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel1 + " == " + $$.label +" ;\n\n";
					}
				}
				else if($1.tipo == "id"){
				
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					

					if ( verificaCast(tempTipo,"==",$3.tipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"==",$3.tipo) == 0 ){
				
						
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " == " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"==",$3.tipo) == 1 ){
				
						tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " == " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"==",$3.tipo) == 2 ){
				
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " == " + $$.label +" ;\n\n";
					}
				}
			
				else if($3.tipo == "id"){
		
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					
		
					if ( verificaCast($1.tipo,"==",tempTipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
		
					if ( verificaCast($1.tipo,"==",tempTipo) == 0 ){
			
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " == " + $1.label +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"==",tempTipo) == 1 ){
			
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
			
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " == " + tempLabel +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"==",tempTipo) == 2 ){
			
						tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();
			
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " == " + $$.label +" ;\n\n";
					}
				}
		
				else
					if(verificaCast($1.tipo,"==",$3.tipo)==-1)
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if(verificaCast($1.tipo,"==",$3.tipo)== 0 ){	
							
							$$.traducao = $1.traducao + $3.traducao + "\t" +
							$$.tipo + " " + $$.label + " = " + $1.label + " == " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"==",$3.tipo)== 1 ){
						$$.tipo = $1.tipo = $3.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " == " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"==",$3.tipo)== 2 ){
						$$.tipo = $3.tipo = $1.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " == " + $$.label +" ;\n\n";
					}
			}
			;

DIFERENTE	: E TK_DIFERENTE E
			{

				$$.tipo = "boolean";
				$$.label = geraLabel();
				
				if($1.tipo == "id" && $3.tipo == "id"){

					string tempLabel1  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					
					
					if ( verificaCast(tempTipo,"!=",tempTipo2) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"!=",tempTipo2) == 0 ){
						
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel1 + " != " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"!=",tempTipo2) == 1 ){
						
						
						tempTipo = tempTipo2;
						mudaTipo(tempLabel1,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel1 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " != " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"!=",tempTipo2) == 2 ){
						
						
						tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel1 + " != " + $$.label +" ;\n\n";
					}
				}

				else if($1.tipo == "id"){
				
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					

					if ( verificaCast(tempTipo,"!=",$3.tipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"!=",$3.tipo) == 0 ){
				
						
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " != " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"!=",$3.tipo) == 1 ){
				
						tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " != " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"!=",$3.tipo) == 2 ){
				
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " != " + $$.label +" ;\n\n";
					}
				}
			
				else if($3.tipo == "id"){
		
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					
		
					if ( verificaCast($1.tipo,"!=",tempTipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
		
					if ( verificaCast($1.tipo,"!=",tempTipo) == 0 ){
			
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " != " + $1.label +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"!=",tempTipo) == 1 ){
			
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
			
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " != " + tempLabel +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"!=",tempTipo) == 2 ){
			
						tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();
			
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " != " + $$.label +" ;\n\n";
					}
				}
		
				else
					if(verificaCast($1.tipo,"!=",$3.tipo)==-1)
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if(verificaCast($1.tipo,"!=",$3.tipo)== 0 ){	
							
							$$.traducao = $1.traducao + $3.traducao + "\t" +
							$$.tipo + " " + $$.label + " = " + $1.label + " != " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"!=",$3.tipo)== 1 ){
						$$.tipo = $1.tipo = $3.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " != " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"!=",$3.tipo)== 2 ){
						$$.tipo = $3.tipo = $1.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " != " + $$.label +" ;\n\n";
					}
			}
			;

MENOR_IGUAL : E TK_MENOR_IGUAL E
			{
				$$.tipo = "boolean";
				$$.label = geraLabel();
	
				if($1.tipo == "id" && $3.tipo == "id"){

					string tempLabel1  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					
					
					if ( verificaCast(tempTipo,"<=",tempTipo2) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"<=",tempTipo2) == 0 ){
						
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel1 + " <= " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"<=",tempTipo2) == 1 ){
						
						
						tempTipo = tempTipo2;
						mudaTipo(tempLabel1,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel1 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " <= " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,"<=",tempTipo2) == 2 ){
						
						
						tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel1 + " <= " + $$.label +" ;\n\n";
					}
				}

				else if($1.tipo == "id"){
				
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					

					if ( verificaCast(tempTipo,"<=",$3.tipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,"<=",$3.tipo) == 0 ){
				
						
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " <= " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"<=",$3.tipo) == 1 ){
				
						tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " <= " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,"<=",$3.tipo) == 2 ){
				
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " <= " + $$.label +" ;\n\n";
					}
				}
			
				else if($3.tipo == "id"){
		
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					
		
					if ( verificaCast($1.tipo,"<=",tempTipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
		
					if ( verificaCast($1.tipo,"<=",tempTipo) == 0 ){
			
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " <= " + $1.label +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"<=",tempTipo) == 1 ){
			
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
			
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " <= " + tempLabel +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,"<=",tempTipo) == 2 ){
			
						tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();
			
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " <= " + $$.label +" ;\n\n";
					}
				}

				else
					if(verificaCast($1.tipo,"<=",$3.tipo)==-1)
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if(verificaCast($1.tipo,"<",$3.tipo)== 0 ){	
							
							$$.traducao = $1.traducao + $3.traducao + "\t" +
							$$.tipo + " " + $$.label + " = " + $1.label + " <= " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"<=",$3.tipo)== 1 ){
						$$.tipo = $1.tipo = $3.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " <= " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,"<=",$3.tipo)== 2 ){
						$$.tipo = $3.tipo = $1.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " <= " + $$.label +" ;\n\n";
					}

			}
			;

MAIOR_IGUAL	: E TK_MAIOR_IGUAL E
			{
				$$.tipo = "boolean";
				$$.label = geraLabel();

				if($1.tipo == "id" && $3.tipo == "id"){

					string tempLabel1  = retornaNome($1.label);
					string tempLabel2 = retornaNome($3.label);
					string tempTipo   = retornaTipo($1.label);
					string tempTipo2  = retornaTipo($3.label);
					
					
					if ( verificaCast(tempTipo,">=",tempTipo2) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,">=",tempTipo2) == 0 ){
						
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel1 + " >= " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,">=",tempTipo2) == 1 ){
						
						
						tempTipo = tempTipo2;
						mudaTipo(tempLabel1,tempTipo2);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel1 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " >= " + tempLabel2 +" ;\n\n";
					}

					if ( verificaCast(tempTipo,">=",tempTipo2) == 2 ){
						
						
						tempTipo2 = tempTipo;
						mudaTipo(tempLabel2,tempTipo);
						string tempLabel0 = geraLabel();

						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")" + tempLabel2 + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel1 + " >= " + $$.label +" ;\n\n";
					}
				}

				else if($1.tipo == "id"){
				
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);
					

					if ( verificaCast(tempTipo,">=",$3.tipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if ( verificaCast(tempTipo,">=",$3.tipo) == 0 ){
				
						
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " >= " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,">=",$3.tipo) == 1 ){
				
						tempTipo = $3.tipo;
						mudaTipo($1.label,$3.tipo);
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " >= " + $3.label +" ;\n\n";
					}
				
					if ( verificaCast(tempTipo,">=",$3.tipo) == 2 ){
				
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
				
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ tempLabel + " >= " + $$.label +" ;\n\n";
					}
				}
			
				else if($3.tipo == "id"){
		
					string tempTipo = retornaTipo($3.label);
					string tempLabel = retornaNome($3.label);
					
		
					if ( verificaCast($1.tipo,">=",tempTipo) == -1 )
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
		
					if ( verificaCast($1.tipo,">=",tempTipo) == 0 ){
			
						
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + tempLabel + " >= " + $1.label +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,">=",tempTipo) == 1 ){
			
						$3.tipo = tempTipo;
						string tempLabel0 = geraLabel();
			
						$$.traducao = $3.traducao + $1.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + tempTipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $$.label + " >= " + tempLabel +" ;\n\n";
					}
			
					if ( verificaCast($1.tipo,">=",tempTipo) == 2 ){
			
						tempTipo = $1.tipo;
						mudaTipo($3.label,$1.tipo);
						string tempLabel0 = geraLabel();
			
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")" + tempLabel + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel0 + " = " + " "+ $1.label + " >= " + $$.label +" ;\n\n";
					}
				}	

				else
					if(verificaCast($1.tipo,">=",$3.tipo)==-1)
						{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}

					if(verificaCast($1.tipo,"<=",$3.tipo)== 0 ){	
							
							$$.traducao = $1.traducao + $3.traducao + "\t" +
							$$.tipo + " " + $$.label + " = " + $1.label + " >= " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,">=",$3.tipo)== 1 ){
						$$.tipo = $1.tipo = $3.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $1.tipo + ")"+ $1.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $$.label + " >= " + $3.label +" ;\n\n";
					}
					
					if(verificaCast($1.tipo,">=",$3.tipo)== 2 ){
						$$.tipo = $3.tipo = $1.tipo;
						
						string tempLabel = geraLabel();
					
						$$.traducao = $1.traducao + $3.traducao + "\t" +
						$$.tipo + " " + $$.label + " = " + " " + "(" + $3.tipo + ")"+ $3.label + " ;\n\n" + "\t" +
						$$.tipo + " " + tempLabel + " = " + " "+ $1.label + " >= " + $$.label +" ;\n\n";
					}
			}			
			;


CAST 		: TK_CAST_INT TK_REAL
			{
				string label = geraLabel(),
						tipo0 = $2.tipo,
						tipo1 = "int",
						temp;
				int p;

				$2.traducao = temp = $2.label;

				p = atoi($2.traducao.c_str());

				$2.traducao = intToString(p);

				$2.label = label;
				$$.tipo = $2.tipo = tipo1;
				string LABEL = geraLabel();
				$$.traducao = "\t" + tipo0 + " " + label + " = " + temp + ";\n\n\t"
				+ tipo1 + " " + LABEL + " = (" + tipo1 + ")" + label + ";\n\n";
				//$$.tipo + " " + LABEL + " = " + $2.traducao + ";\n\n";



			}
			| TK_CAST_INT TK_ID
			{
				string tempTipoA = retornaTipo($2.label);
				string tempLabel = retornaNome($2.label);

				$$.label = geraLabel();

				if ( tempTipoA == "float"){

					mudaTipo($2.label,"int");
					string tempTipo = retornaTipo($2.label);


					$$.traducao = $1.traducao + $2.traducao + "\t" +
					tempTipo + " " + $$.label + " = (" + tempTipo + ")" + tempLabel + ";\n\n";



				}
				else{
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
				}

			}
			| TK_CAST_FLOAT TK_INT
			{
				string label = geraLabel(),
						tipo0 = $2.tipo,
						tipo1 = "float",
						temp;

				$2.traducao = $2.label;
				temp = $2.traducao;
				$2.traducao.append(".0");
				$2.label = label;
				$$.tipo = $2.tipo = tipo1;

				$$.traducao = "\t" + tipo0 + " " + label + " = " + temp + ";\n\n\t"
				+ tipo0 + " " + label + " = (" + tipo1 + ")" + label + ";\n\n\t"+
				$$.tipo + " " + label + " = " + $2.traducao + ";\n\n";
			}
			| TK_CAST_FLOAT TK_ID
			{
				string tempTipoA = retornaTipo($2.label);
				string tempLabel = retornaNome($2.label);
				$$.label = geraLabel();

				if ( tempTipoA == "int"){

					mudaTipo($2.label,"float");
					string tempTipo = retornaTipo($2.label);


					$$.traducao = $1.traducao + $2.traducao + "\t" +
					tempTipo + " " + $$.label + " = (" + tempTipo + ")" + tempLabel + ";\n\n";



				}
				else{
					{erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
				}
			}
			;

CIN 		: TK_CIN '(' TK_ID ')'
			{
				if(verificaDeclaracao($3.label)==1){
					string tempLabel = retornaNome($3.label);
					$$.traducao = $1.traducao + $3.traducao + "\t"
					+ "cin >> " + tempLabel + ";\n\n";
				}
				if(verificaDeclaracao($3.label)==0){
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);}
			}
			;

COUT 		: TK_COUT '(' TK_ID ')'
			{
				if(verificaDeclaracao($3.label)==1){
					string tempLabel = retornaNome($3.label);
					$$.traducao = $1.traducao + $3.traducao + "\t"
					+ "cout<< " + tempLabel + " << endl;\n\n";
				}	
				if(verificaDeclaracao($3.label)==0){
					erro = "Erro de Semântica na Linha : " + to_string(linha);
					yyerror(erro);
				}
			}
			;

%%

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

	char buffer[50];
	string temp;

	numero++;

	sprintf(buffer,"temp%d",numero);

	temp = buffer;

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

string intToString(int p){
	string s;
	char buffer [50];
	sprintf(buffer,"%d",p);
	s=buffer;
	return s;
}

void addVarMap(string tipo,string id,string nome){

	variavel vari = {tipo,nome};

	mapVar[id] = vari;
}


int verificaDeclaracao(string id ){

	if(mapVar.find(id) != mapVar.end()){
		return 1;
	}
	return 0;

}

string retornaNome(string id){

	/*if(mapVar.find(id) != mapVar.end()){
		return NULL;
	}*/
	return mapVar[id].nome;

}

string retornaTipo(string id){

	/*if(mapVar.find(id) != mapVar.end()){
		return NULL;
	}*/
	return mapVar[id].tipo;

}

void mudaTipo(string id, string tipo){

	/*if(mapVar.find(id) != mapVar.end()){
		return NULL;
	}*/
	mapVar[id].tipo = tipo;
}
