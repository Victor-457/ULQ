/* OBSERVAÇÕES:
 *
 * TEM QUE ARRUMAR DECLARA RECEBENDO EXP logic e Testar recebendo o exp rel
 *
 * Achei desnecessario poder fazer uma variavel receber true== false ou true and true sem ser atraveś de variaveis ja
 declaradas, então eu tirei isso
 *
 * Tem uma gambiarra na função que imprime as variaveis pq quando faz o cast de uma variavel na hora de fazer uma operação printava um tipo voando sem nome associado a ele ae eu coloquei aquele if com um continue dentro para parar de printar ele
 *
 * O tipo_traducao adicionado no atributos é uma gambiarra para passar coisas de uma expressão para outra sem aparecer no codigo
 * intermediario antes eu usava o traducao para isso mas aparecia lá
 *	CAST NA DECLARAÇÃO!!!!!!!!!!!!!
 * DEVE-SE UTLIZAR OPERACOES RELACIONAIS PARA BOOLEAN, CHAR E STRING TAMBEM!!!!!!!!!!!!!!!!!!!!!
 * O CAST EXPLICITO ESTA PARCIALMENTE ERRADO, DEVE-SE USAR EM CONSTANTES TAMBEM!!!!!!!!
 * IF NÃO É QUEBRAVEL AO CHAMAR BREAK E CONTINUE DEVE-SE IR PARA O ROTULO DO BLOCO QUEBRAVEL
 * Atualmente um float não pode receber uma operação entre inteiros(acho que podemos deixar isso como uma caracteristica da nossa linguagem)
 *
 * Falta adicionar expressões com os outros tipo e expressões que suportem expressões lógicas em declarações.
 *
 * Preencher as seguintes expressões tipo id = log1 no DECLARA e id = log1 no ALTERA e testar os oplog(que é somente o not e o oplog1 é o and e o or)
 *
 * Entender/fazer ou refazer não sei dizer a string
 *
 * Ajustar o bloco para suportar loops e condicionais
 *
 * Criar if, else if, else, switch(é assim que escreve? não lembro mais kkk)
 *
 * Criar For,do while,while
 *
 * Criar a função geradora de rotulos
 *
 * Criar break e continue(OBS o super break pode ser uma feature a mais)
 *
 * Quando fazer string vai ter de mexer na expressão io
*/

%{
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

%}

%token TK_INT TK_REAL TK_BOOLEAN TK_CHAR TK_STRING TK_ID TK_MAIN TK_TIPO TK_TIPO_VAR TK_TIPO_STRING

%token TK_ADD_SUB TK_MULT_DIV_RES TK_REL TK_LOGIC TK_ATRIBUICAO TK_CAST TK_IN TK_OUT TK_NOT

%token TK_COND TK_LOOP TK_FIM TK_ERROR

%start S

%left TK_ADD_SUB
%left TK_MULT_DIV_RES
%left TK_REL
%left TK_LOGIC
%left TK_NOT

%%

S 			: BLOCOGLOBAL D TK_MAIN '(' ')' BLOCO
			{
				string s = declara_variaveis_temp(pilhaVar[pilhaPos],0);
				cout << "/*Compilador Uma Linguagem Qualquer*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\n\nusing namespace std;\n"<< s <<$2.traducao << "\nint main(void)\n{\n" << $6.traducao << "\treturn 0;\n}" << endl;
			}
			;

BLOCOGLOBAL:/* regra vazia pq sempre vai acontecer logo q o lex começar sempre q tiver uma variavel global
sendo declarada */
			{
					empilhaNovoMapa();
			}

BLOCO		: '{' COMANDOS '}'
			{

				pilhaPos = pilhaVar.size() - 1; // Pego o topo da pilha
				string s = declara_variaveis_temp(pilhaVar[pilhaPos],1);
				$$.traducao = s + $2.traducao;
				pilhaVar.pop_back();// desempilho o mapa ao final do bloco
				pilhaPos = pilhaVar.size() - 1;
			}
			;

D 			: D DECLARA ';'
			{
				$$.traducao = $1.traducao + $2.traducao;
			}
			|

COMANDOS	: COMANDO COMANDOS
			{
				$$.traducao = $1.traducao + $2.traducao;
			}
			|
			;

COMANDO 	: DECLARA ';'
			| IN ';'
			| OUT ';'
			| CAST ';'
			| ALTERA ';'
			;

STRING 		: TK_TIPO_STRING TK_ID TK_ATRIBUICAO TK_STRING
			{
				buscaMapa($2.label,1);

				if(verificaDeclaracao($2.label) == 1){
					
					erro = "Erro de Semântica na Linha : Eu to na string " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($2.label) == 0){
					
					$$.label = geraLabel();
					
					addVarMap($1.tipo,$2.label,$$.label,$4.label);
					
					string tam = to_string($4.tamanho);
					setTamString($2.label,tam);
					
					$$.traducao = "strcpy(" + $$.label + "," + $4.label + ");\n\n" ;
				}


			}
			;

DECLARA 	: STRING

			| TK_TIPO TK_ID TK_ATRIBUICAO TK_INT
			{

				if($1.label=="int"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha :  eu to na declaracao de int atribuindo valor" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();
						$$.traducao = $$.label + " = " + $4.label + ";\n";

						addVarMap($1.label,$2.label,$$.label,$4.label);
					}
				}

				else{

					erro = "Erro de Semântica na Linha :  eu to na declaracao de int atribuindo valor2" + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO TK_ADD_SUB TK_INT
			{

				if($1.label == "int" && $4.label == "-"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id 	já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de int atribuindo valor negativo" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();
						string temp = "-" + $5.label;
						$$.traducao = $$.label + " = " + temp + ";\n";

						addVarMap($1.label,$2.label,$$.label,temp);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de int atribuindo valor negativo " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO TK_REAL
			{
				if($1.label == "float"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id 	já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de real atribuindo valor " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();
						$$.traducao = $$.label + " = " + $4.label + ";\n";

						addVarMap($1.label,$2.label,$$.label,$4.label);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de real atribuindo valor2 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO TK_ADD_SUB TK_REAL
			{

				if($1.label == "float" && $4.label == "-"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id 	já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de real atribuindo valor negativo " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();
						string temp = "-" + $5.label;
						$$.traducao = $$.label + " = " + temp + ";\n";

						addVarMap($1.label,$2.label,$$.label,temp);
					}
				}

				else{

					erro = "Erro de Semântica na Linha :  eu to na declaracao de real atribuindo valor negativo" + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO TK_CHAR
			{

				if($1.label == "char"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de char atribuindo valor " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();
						$$.traducao = $$.label + " = " + $4.label + ";\n";

						addVarMap($1.label,$2.label,$$.label,$4.label);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de char atribuindo valor2 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO TK_BOOLEAN
			{

				if($1.label == "bool"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de boolean atribuindo valor " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();

						if($4.label=="true"){

							$$.traducao = $$.label + " = " + "1" + ";\n";
							addVarMap($1.label,$2.label,$$.label,"1");
						}

						else if($4.label == "false"){

							$$.traducao = $$.label + " = " + "0" + ";\n";
							addVarMap($1.label,$2.label,$$.label,"0");
						}
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de boolean atribuindo valor2 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO OP_ARIT
			{
				buscaMapa($2.label,1);

				if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

					erro = "Erro de Semântica na Linha : eu to na declaracao de exp ARIT atribuindo valor " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($2.label) == 0){

					$$.label = geraLabel();

					if($1.label == $4.tipo){

						if($4.label == "NULL"){

							$$.traducao = $$.label + " = " + $4.tipo_traducao + " ;\n\n";

							addVarMap($1.label,$2.label,$$.label,$4.tipo_traducao);
						}

						else{

							//cout<<$4.label<<endl<<endl<<$$.label<<endl<<$4.tipo_traducao<<endl;

							$$.traducao = $4.label + $$.label + " = " + $4.tipo_traducao + " ;\n\n";

							addVarMap($1.label,$2.label,$$.label,$4.tipo_traducao);
						}
					}

					else{

						erro = "Erro de Semântica na Linha : eu to na declaracao de expressões atribuindo valor2 (tipo da variavel que vai receber a exp esta errado) " + to_string(linha);
						yyerror(erro);
					}
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO '(' OP_REL ')'
			{
				if($1.label == "bool"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de exp REL atribuindo valor(variavel ja existente) " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();

						if($5.label == "NULL"){

							$$.traducao = $$.label + " = " + $5.tipo_traducao + " ;\n\n";

							addVarMap($1.label,$2.label,$$.label,$5.tipo_traducao);
						}

						else{

							$$.traducao = $5.label + $$.label + " = " + $5.tipo_traducao + " ;\n\n";

							addVarMap($1.label,$2.label,$$.label,$5.tipo_traducao);
						}

					}


				}

				else{

					erro = "Erro de Semântica na Linha : eu to na declaracao de expressões atribuindo valor3(Relacional)(tipo da variavel que vai receber a exp esta errado) " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO OP_LOG
			{
				if($1.label == "bool"){

					buscaMapa($2.label,1);

					if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						erro = "Erro de Semântica na Linha : eu to na declaracao de exp REL atribuindo valor(variavel ja existente) " + to_string(linha);
						yyerror(erro);
					}

					else if(verificaDeclaracao($2.label) == 0){


						$$.label = geraLabel();

						$$.traducao = $$.label +  $4.label;

						addVarMap($1.label,$2.label,$$.label,$4.tipo_traducao);
					}
				}
			}

			| TK_TIPO TK_ID TK_ATRIBUICAO OP_LOG1
			{
				//**************Definir conteudo*****************************************
			}

			| TK_TIPO TK_ID
			{

				buscaMapa($2.label,1);

				if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

					erro = "Erro de Semântica na Linha : eu to na declaracao de variavel sem atribuir valor " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($2.label) == 0){

						$$.label = geraLabel();
						addVarMap($1.label,$2.label,$$.label,"");

				}
			}

			| TK_TIPO_VAR TK_ID
			{

				buscaMapa($2.label,1);

				if(verificaDeclaracao($2.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

					erro = "Erro de Semântica na Linha :  to no qualquer" + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($2.label) == 0){

					$$.label = geraLabel();
					addVarMap($1.label,$2.label,$$.label,"");
				}
			}
			;

ALTERA 		: TK_ID TK_ATRIBUICAO TK_BOOLEAN
			{
				buscaMapa($1.label,0);
				if(verificaDeclaracao($1.label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if($3.tipo == temp){

						if($3.label == "true"){
							alteraValor($1.label,"1");
							$$.traducao = tempLabel + " = 1;\n"; // Printa no código intermediário a alteração
						}

						else if($3.label == "false"){
							alteraValor($1.label,"0");
							$$.traducao = tempLabel + " = 0;\n";
						}
					}
					else if(temp == ""){

						mudaTipo($1.label,"int");

						if($3.label == "true"){

							alteraValor($1.label,"1");
							$$.traducao = tempLabel + " = 1;\n"; // Printa no código intermediário a alteração
						}

						else if($3.label == "false"){

							alteraValor($1.label,"0");
							$$.traducao = tempLabel + " = 0;\n";
						}

					}

					else if($3.tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável boolean

						erro = "Erro de Semântica na Linha : eu to na altera boolean " + to_string(linha);
						yyerror(erro);
					}
				}

				else if(verificaDeclaracao($1.label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha :  eu to na altera boolean2" + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID TK_ATRIBUICAO TK_CHAR
			{

				buscaMapa($1.label,0);
				if(verificaDeclaracao($1.label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if($3.tipo == temp){

						alteraValor($1.label,$3.label);
						$$.traducao =tempLabel + " = " + $3.label + ";\n"; // Printa no código intermediário a alteração
					}

					else if(temp == ""){

						alteraValor($1.label,$3.label);
						mudaTipo($1.label,$3.tipo);

						$$.traducao = tempLabel + " = " + $3.label + ";\n"; // Printa no código intermediário a alteração
					}

					else if($3.tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável char

						erro = "Erro de Semântica na Linha : eu to na altera char " + to_string(linha);
						yyerror(erro);
					}
				}

				else if(verificaDeclaracao($1.label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha : eu to na altera char2 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID TK_ATRIBUICAO TK_REAL
			{

				buscaMapa($1.label,0);

				if(verificaDeclaracao($1.label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if($3.tipo == temp){

						alteraValor($1.label,$3.label);
						$$.traducao =tempLabel + " = " + $3.label + ";\n"; // Printa no código intermediário a alteração
					}

					else if(temp == ""){

						alteraValor($1.label,$3.label);
						mudaTipo($1.label,$3.tipo);

						$$.traducao = tempLabel + " = " + $3.label + ";\n"; // Printa no código intermediário a alteração
					}

					else if($3.tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável real

						erro = "Erro de Semântica na Linha : eu to na altera real " + to_string(linha);
						yyerror(erro);

					}
				}

				else if(verificaDeclaracao($1.label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha : eu to na altera real 2 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID TK_ATRIBUICAO TK_ADD_SUB TK_REAL
			{

				if($3.label == "-"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){ // Está tentando declarar uma variavel já existente, ou seja está usando um id já declarado.

						string temp = retornaTipo($1.label);
						string tempLabel = retornaNome($1.label);

						if($4.tipo == temp){

							string tempV = "-" + $4.label;
							alteraValor($1.label,tempV);

							$$.traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if(temp == ""){

							string tempV = "-" + $4.label;
							alteraValor($1.label,tempV);
							mudaTipo($1.label,$4.tipo);

							$$.traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if($4.tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável real

							erro = "Erro de Semântica na Linha : eu to na altera real negativo " + to_string(linha);
							yyerror(erro);
						}
					}

					else if(verificaDeclaracao($1.label) == 0){// Variavel não declarada

						erro = "Erro de Semântica na Linha : eu to na altera real negativo2 " + to_string(linha);
						yyerror(erro);
					}
				}

				else{

					erro = "Erro de Semântica na Linha : eu to na altera real negativo3 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID TK_ATRIBUICAO TK_INT
			{
				buscaMapa($1.label,0);

				if(verificaDeclaracao($1.label) == 1){ // Está tentando alterar o valor uma variavel já existente.

					string temp = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if($3.tipo == temp){

						alteraValor($1.label,$3.label);
						$$.traducao = tempLabel + " = " + $3.label + ";\n"; // Printa no código intermediário a alteração
					}

					else if(temp == ""){

						alteraValor($1.label,$3.label);
						mudaTipo($1.label,$3.tipo);

						$$.traducao = tempLabel + " = " + $3.label + ";\n"; // Printa no código intermediário a alteração
					}

					else if($3.tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável inteira

						erro = "Erro de Semântica na Linha : eu to na altera int " + to_string(linha);
						yyerror(erro);
					}
				}

				else if(verificaDeclaracao($1.label) == 0){// Variavel não declarada

					erro = "Erro de Semântica na Linha : eu to na altera int2 " + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID TK_ATRIBUICAO TK_ADD_SUB TK_INT
			{

				if($3.label == "-"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){ // Está alterandor uma variavel já existente, ou seja está usando um id já declarado.

						string temp = retornaTipo($1.label);
						string tempLabel = retornaNome($1.label);

						if($4.tipo == temp){

							string tempV = "-" + $4.label;
							alteraValor($1.label,tempV);

							$$.traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if(temp == ""){

							string tempV = "-" + $4.label;
							alteraValor($1.label,tempV);
							mudaTipo($1.label,$4.tipo);

							$$.traducao = tempLabel + " = " + tempV + ";\n"; // Printa no código intermediário a alteração
						}

						else if($4.tipo != temp){ // Está tentando atribuir um valor de um tipo diferente a uma variável inteira

							erro = "Erro de Semântica na Linha : eu to na altera int negativo " + to_string(linha);
							yyerror(erro);
						}
					}

					else if(verificaDeclaracao($1.label) == 0){ // Variavel não declarada

						erro = "Erro de Semântica na Linha :  eu to na altera int negativo2" + to_string(linha);
						yyerror(erro);
					}
				}

				else{

					erro = "Erro de Semântica na Linha :  eu to na altera int negativo3" + to_string(linha);
					yyerror(erro);
				}
			}

			| TK_ID TK_ATRIBUICAO OP_ARIT
			{

				buscaMapa($1.label,0);

				if(verificaDeclaracao($1.label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões  arit " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($1.label) == 1){

					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if(tempTipo == $3.tipo){

						if($3.label == "NULL"){

							alteraValor($1.label,$3.tipo_traducao);
							$$.traducao = tempLabel + " = " + $3.tipo_traducao + " ;\n\n";
						}

						else{
							alteraValor($1.label,$3.tipo_traducao);
							$$.traducao = $3.label + tempLabel + " = " + $3.tipo_traducao + " ;\n\n";
						}

					}

					else{
						erro = "Erro de Semântica na Linha : eu to na altera com expressões arit2  " + to_string(linha);
						yyerror(erro);
					}


				}
			}

			| TK_ID TK_ATRIBUICAO '(' OP_REL ')'
			{
				buscaMapa($1.label,0);

				if(verificaDeclaracao($1.label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões REL " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($1.label) == 1){

					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if(tempTipo == "bool"){

						if($4.label == "NULL"){

							alteraValor($1.label,$4.tipo_traducao);
							$$.traducao = tempLabel + " = " + $4.tipo_traducao + " ;\n\n";
						}

						else{
							alteraValor($1.label,$4.tipo_traducao);
							$$.traducao = $4.label + tempLabel + " = " + $4.tipo_traducao + " ;\n\n";
						}

					}

					else{
						erro = "Erro de Semântica na Linha : eu to na altera com expressões REL 2  " + to_string(linha);
						yyerror(erro);
					}

				}
			}

			| TK_ID TK_ATRIBUICAO OP_LOG
			{

				buscaMapa($1.label,0);

				if(verificaDeclaracao($1.label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões  not3 " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($1.label) == 1){

					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if(tempTipo == "bool" || tempTipo == "boolean"){
						alteraValor($1.label,$3.tipo);

						$$.traducao = tempLabel + " " + $3.label;
					}
					else{
						erro = "Erro de Semântica na Linha : eu to no OP not 4 " + to_string(linha);
						yyerror(erro);
					}
				}
			}

			| TK_ID TK_ATRIBUICAO OP_LOG1
			{
				buscaMapa($1.label,0);

				if(verificaDeclaracao($1.label) == 0){

					erro = "Erro de Semântica na Linha : eu to na altera com expressões  OP_LOG1 " + to_string(linha);
					yyerror(erro);
				}

				else if(verificaDeclaracao($1.label) == 1){
					string tempTipo = retornaTipo($1.label);
					string tempLabel = retornaNome($1.label);

					if(tempTipo == "bool" || tempTipo == "boolean"){
						alteraValor($1.label,$3.tipo);

						$$.traducao = tempLabel + " " + $3.label;
					}
					else{
						erro = "Erro de Semântica na Linha : eu to no OP_LOG1 2 " + to_string(linha);
						yyerror(erro);
					}
				}
			}

			| OP_LOG
			{
				buscaMapa($1.traducao,0);
				$$.traducao = $1.tipo_traducao;
			}
			;

TERM		: TK_INT
		    {
		    	buscaMapa($1.label,0);

		    	if(verificaDeclaracao($1.label) == 0){

		    		string nome = geraLabel();
	    	 		$$.label = $1.label;
		    		$$.tipo = $1.tipo;

					$$.traducao = nome + " = " + $$.label + ";\n";

		    		addVarMap($$.tipo,$$.label,nome,$$.label);
		    	}
		    }

			| TK_ADD_SUB TK_INT /*regra para ler inteiros negativos*/
			{

				$$.label = "-" + $2.label;

				buscaMapa($$.label,0);

		    	if(verificaDeclaracao($$.label) == 0){

					if($1.label == "-"){

						string nome = geraLabel();
			    		$$.tipo = $2.tipo;
						$$.traducao = nome + " = " + $$.label + ";\n";

			    		addVarMap($$.tipo,$$.label,nome,$$.label);
			    	}

		    		else{

						erro = "Erro de Semântica na Linha : eu to no term int negativo " + to_string(linha);
						yyerror(erro);
					}
				}
			}

			| TK_REAL
		    {

	    		buscaMapa($1.label,0);

		    	if(verificaDeclaracao($1.label) == 0){

			    	string nome = geraLabel();
	    		 	$$.label = $1.label;
		    		$$.tipo = $1.tipo;
		    		$$.traducao = nome + " = " + $$.label + ";\n";

		    		addVarMap($$.tipo,$$.label,nome,$$.label);
			    }
			}

			| '-' TK_REAL /*regra para ler reais negativos */
			{
				$$.label = "-" + $2.label;

				buscaMapa($$.label,0);

		    	if(verificaDeclaracao($$.label) == 0){

					if($1.label == "-"){
						string nome = geraLabel();
			    		$$.tipo = $2.tipo;
			    		$$.traducao = nome + " = " + $$.label + ";\n";

			    		addVarMap($$.tipo,$$.label,nome,$$.label);
			    	}
			    	else{

						erro = "Erro de Semântica na Linha : eu to no term real negativo " + to_string(linha);
						yyerror(erro);
					}
				}
			}

			| TK_CHAR
		    {
		    	buscaMapa($1.label,0);

		    	if(verificaDeclaracao($$.label) == 0){

		    		string nome = geraLabel();
	    	 		$$.label = $1.label;
		    		$$.tipo = $1.tipo;
		    		$$.traducao = nome + " = " + $$.label + ";\n";

		    		addVarMap($$.tipo,$$.label,nome,$$.label);
		    	}
			}

			| TK_BOOLEAN
		    {
		   		/* adiciona a variavel boolean autilizada num mapa de variaveis com tipo igual a int e id igual a 1 ou 0 se ele já não estiver lá */
		     	if(verificaDeclaracao($1.label)==0){

		   	 		$$.label = geraLabel();

		    		if($1.label == "true"){

		    			string nome = geraLabel();
	    	 			$$.label = "1";
		    			$$.tipo = $1.tipo;
		    			$$.traducao = nome + " = " + $$.label + ";\n";

		    			addVarMap($$.tipo,$$.label,nome,$$.label);
		    		}

		    		else if($1.label == "false"){

		    			string nome = geraLabel();
	    	 			$$.label = "0";
		    			$$.tipo = $1.tipo;
		    			$$.traducao = nome + " = " + $$.label + ";\n";

		    			addVarMap($$.tipo,$$.label,nome,$$.label);
		    		}
		    	}
		    }

		    | TK_ID
		    {
		    }
			;

OP_ARIT		: TERM TK_ADD_SUB OUTRA_OP//Modifiquei pra ao invés de levar em TERM levar em OUTRA_OP
			{

				if($1.tipo == "id" && $3.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label);

						buscaMapa($3.label,0);

						if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome($3.label),
								   tempTipo3  = retornaTipo($3.label);

							if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id + id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

								$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
								$$.label = "NULL";
								$$.tipo = tempTipo1;
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

								string temp = geraLabel();
								mudaTipo(tempLabel1,tempTipo3);

								$$.label = temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
								$$.tipo_traducao =  temp + " " + $2.label + " " + tempLabel3;
								$$.tipo = tempTipo3;

								addVarMap(tempTipo3,temp,temp,$$.traducao);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

								string temp = geraLabel();
								mudaTipo(tempLabel3,tempTipo1);

								$$.label = temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
								$$.tipo_traducao =  tempLabel1 + $2.label + temp;
								$$.tipo = tempTipo1;

								addVarMap(tempTipo1,temp,temp,$$.traducao);
							}
						}
					}
				}

				else if($1.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id + term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
							$$.label = $3.traducao + "\n";
							$$.tipo = tempTipo1;

						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							$$.label = $3.traducao + "\n"+ temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							$$.tipo_traducao =  temp + " " + $2.label + " " + tempLabel3;
							$$.tipo = tempTipo3;

							addVarMap(tempTipo3,temp,temp,$$.traducao);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							$$.label = $3.traducao + "\n"+ temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							$$.tipo_traducao =  tempLabel1 + $2.label + temp;
							$$.tipo = tempTipo1;

							addVarMap(tempTipo1,temp,temp,$$.traducao);
						}
					}
				}

				else if($3.tipo == "id"){

					buscaMapa($3.label,0);

					if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term + id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
							$$.label = $1.traducao;
							$$.tipo = tempTipo1;
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							$$.label =$1.traducao + "\n"+ temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							$$.tipo_traducao =  tempLabel1 + $2.label + temp;
							$$.tipo = tempTipo3;

							addVarMap(tempTipo1,temp,temp,$$.traducao);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							$$.label =$1.traducao + "\n"+ temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							$$.tipo_traducao =  temp + " " + $2.label + " " + tempLabel3;
							$$.tipo = tempTipo1;

							addVarMap(tempTipo3,temp,temp,$$.traducao);
						}
					}
				}

				else{

					string tempTipo1  = retornaTipo($1.label),
						   tempLabel3 = retornaNome($3.label),
						   tempLabel1 = retornaNome($1.label),
						   tempTipo3  = retornaTipo($3.label);

					if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term + term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

						$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
						$$.label = $1.traducao + $3.traducao;
						$$.tipo = tempTipo1;
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						$$.label = $1.traducao + $3.traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						$$.tipo_traducao =  tempLabel1 + $2.label + temp;
						$$.tipo = tempTipo3;

						addVarMap(tempTipo1,temp,temp,$$.traducao);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						$$.label = $1.traducao + $3.traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						$$.tipo_traducao =  tempLabel1 + $2.label + temp;
						$$.tipo = tempTipo1;

						addVarMap(tempTipo1,temp,temp,$$.traducao);
					}
				}
			}

			| TERM TK_MULT_DIV_RES TERM
			{

				if($1.tipo == "id" && $3.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label);

						buscaMapa($3.label,0);

						if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome($3.label),
								   tempTipo3  = retornaTipo($3.label);

							if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id * id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

								$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
								$$.label = "NULL";
								$$.tipo = tempTipo1;
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

								string temp = geraLabel();
								mudaTipo(tempLabel1,tempTipo3);

								$$.label = temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
								$$.tipo_traducao =  temp + " " + $2.label + " " + tempLabel3;
								$$.tipo = tempTipo3;

								addVarMap(tempTipo3,temp,temp,$$.traducao);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

								string temp = geraLabel();
								mudaTipo(tempLabel3,tempTipo1);

								$$.label = temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
								$$.tipo_traducao =  tempLabel1 + $2.label + temp;
								$$.tipo = tempTipo1;

								addVarMap(tempTipo1,temp,temp,$$.traducao);
							}
						}
					}
				}

				else if($1.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id * term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
							$$.label =$3.traducao + "\n\n";
							$$.tipo = tempTipo1;
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							$$.label = $3.traducao + "\n\n" + temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							$$.tipo_traducao =  temp + " " + $2.label + " " + tempLabel3;
							$$.tipo = tempTipo3;

							addVarMap(tempTipo3,temp,temp,$$.traducao);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							$$.label = $3.traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							$$.tipo_traducao =  tempLabel1 + $2.label + temp;
							$$.tipo = tempTipo1;

							addVarMap(tempTipo1,temp,temp,$$.traducao);
						}
					}
				}

				else if($3.tipo == "id"){

					buscaMapa($3.label,0);

					if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term * id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao = tempLabel1 + " " + $2.label + " " + tempLabel3;
							$$.label = $1.traducao + "\n\n";

							$$.tipo = tempTipo1;
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							$$.label = $1.traducao + "\n\n" + temp + " = (" + tempTipo3 + ")" + tempLabel1 + " ;\n\n";
							$$.tipo_traducao =  tempLabel3 + $2.label + temp;
							$$.tipo = tempTipo3;

							addVarMap(tempTipo3,temp,temp,$$.tipo_traducao);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							$$.label = $1.traducao + "\n\n" + temp + " = (" + tempTipo1 + ")"+ tempLabel3 + " ;\n\n";
							$$.tipo_traducao =  temp + " " + $2.label + " " + tempLabel1;
							$$.tipo = tempTipo1;

							addVarMap(tempTipo1,temp,temp,$$.tipo_traducao);
						}
					}
				}

				else{

					string tempLabel1 = retornaNome($1.label),
						   tempTipo1  = retornaTipo($1.label),
						   tempLabel3 = retornaNome($3.label),
						   tempTipo3  = retornaTipo($3.label);

					if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term * term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

						$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
						$$.label = $1.traducao + $3.traducao;
						$$.tipo = tempTipo1;
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						$$.label = $1.traducao + $3.traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						$$.tipo_traducao =  tempLabel1 + $2.label + temp;
						$$.tipo = tempTipo3;

						addVarMap(tempTipo1,temp,temp,$$.traducao);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						$$.label = $1.traducao + $3.traducao + "\n\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						$$.tipo_traducao =  tempLabel1 + $2.label + temp;
						$$.tipo = tempTipo1;

						addVarMap(tempTipo1,temp,temp,$$.traducao);
					}
				}
			}
			;

OUTRA_OP	: TERM TK_ADD_SUB OUTRA_OP{//Esse OUTRA_OP permite fazer operacoes aritmeticas de tamanho n, porém eu não to sabendo o que fazer pro cod intermediario sair


			}
			;
			| TERM {


			}
			;

OP_REL		: TERM TK_REL TERM
			{
				if($1.tipo == "id" && $3.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label);

						buscaMapa($3.label,0);

						if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome($3.label),
								   tempTipo3  = retornaTipo($3.label);

							if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id < id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

								$$.tipo_traducao = "(" + tempLabel1 + " " + $2.label + " " + tempLabel3 + ")";
								$$.label = "NULL";

							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

								string temp = geraLabel();
								mudaTipo(tempLabel1,tempTipo3);

								$$.label = temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
								$$.tipo_traducao = "(" + temp + " " + $2.label + " " + tempLabel3 + ")";

								addVarMap(tempTipo3,temp,temp,$$.traducao);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

								string temp = geraLabel();
								mudaTipo(tempLabel3,tempTipo1);

								$$.label = temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
								$$.tipo_traducao =  "(" + tempLabel1 + $2.label + temp + ")";

								addVarMap(tempTipo1,temp,temp,$$.traducao);
							}
						}
					}
				}

				else if($1.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id > term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.traducao =  "(" + tempLabel1 + " " + $2.label + " " + tempLabel3 + ")";
							$$.label = $3.traducao;

						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							$$.label = $3.traducao + "\n" + temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							$$.tipo_traducao = "(" + temp + " " + $2.label + " " + tempLabel3 + ")";


							addVarMap(tempTipo3,temp,temp,$$.traducao);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							$$.label =  $3.traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							$$.tipo_traducao = "(" + tempLabel1 + $2.label + temp + ")";

							addVarMap(tempTipo1,temp,temp,$$.traducao);
						}
					}
				}

				else if($3.tipo == "id"){

					buscaMapa($3.label,0);

					if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);
							   cout<< tempLabel1 << endl<< tempTipo1;
						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term > id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao = "(" + tempLabel1 + " " + $2.label + " " + tempLabel3 + ")";
							$$.label =  $1.traducao;

						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

							string temp = geraLabel();
							mudaTipo(tempLabel3,tempTipo1);

							$$.label = $1.traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
							$$.tipo_traducao = "(" + tempLabel1 + $2.label + temp + ")";

							addVarMap(tempTipo1,temp,temp,$$.traducao);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

							string temp = geraLabel();
							mudaTipo(tempLabel1,tempTipo3);

							$$.label = $1.traducao + "\n" + temp + " = (" + tempTipo3 + ")"+ tempLabel1 + " ;\n\n";
							$$.tipo_traducao = "(" + temp + " " + $2.label + " " + tempLabel3 + ")";

							addVarMap(tempTipo3,temp,temp,$$.traducao);
						}
					}
				}
				else{

					string tempLabel1 = retornaNome($1.label),
						   tempTipo1  = retornaTipo($1.label),
						   tempLabel3 = retornaNome($3.label),
						   tempTipo3  = retornaTipo($3.label);

					if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term > term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

						$$.tipo_traducao = "(" + tempLabel1 + " " + $2.label + " " + tempLabel3 + ")";
						$$.label = $1.traducao + $3.traducao;
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 1){// a primeira variavel precisa de cast implicito para o tipo da segunda

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						$$.label = $1.traducao + $3.traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						$$.tipo_traducao = "(" + tempLabel1 + $2.label + temp + ")";

						addVarMap(tempTipo1,temp,temp,$$.traducao);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 2){// a segunda variavel precisa de cast implicito para o tipo da primeira

						string temp = geraLabel();
						mudaTipo(tempLabel3,tempTipo1);

						$$.label = $1.traducao + $3.traducao + "\n" + temp + " = (" + tempTipo1 + ")" + tempLabel3 + " ;\n\n";
						$$.tipo_traducao = "(" + tempLabel1 + $2.label + temp + ")";

						addVarMap(tempTipo1,temp,temp,$$.traducao);
					}
				}
			}
			;

OP_LOG		: TK_NOT TK_ID
			{

				buscaMapa($2.label,0);

				if(verificaDeclaracao($2.label) == 1){

					string tempTipo = retornaTipo($2.label);

					if(tempTipo == "bool"){

						string tempLabel = retornaNome($2.label),
						tempValor = retornaValor($2.label);

						if(tempValor == "1"){
							$$.label = " = 0;\n\n";
							alteraValor($2.label,"0");
							$$.tipo_traducao = tempLabel + " = 0;\n\n";
						}

						else if(tempValor == "0"){
							$$.label = " = 1;\n\n";
							alteraValor($2.label,"1");
							$$.tipo_traducao = tempLabel + " = 1;\n\n";
						}
						$$.tipo = tempValor;
						$$.traducao = $2.label;
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
			;

OP_LOG1 	: TERM TK_LOGIC TERM
			{

				if($1.tipo == "id" && $3.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label);

						buscaMapa($3.label,0);

						if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

							string tempLabel3 = retornaNome($3.label),
								   tempTipo3  = retornaTipo($3.label);

							if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

								erro = "Erro de Semântica na Linha : eu to no OP id and id" + to_string(linha);
								yyerror(erro);
							}

							else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

								$$.tipo_traducao =  tempLabel1 + " " + $2.label + " " + tempLabel3;
							}
						}
					}
				}

				else if($1.tipo == "id"){

					buscaMapa($1.label,0);

					if(verificaDeclaracao($1.label) == 1){//verifica se a primeira variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das 	variaveis

							erro = "Erro de Semântica na Linha : eu to no OP id and term" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao = $3.traducao + tempLabel1 + " " + $2.label + " " + tempLabel3;
						}
					}
				}

				else if($3.tipo == "id"){

					buscaMapa($3.label,0);

					if(verificaDeclaracao($3.label) == 1){//verifica se a segunda variavel foi declarada

						string tempLabel1 = retornaNome($1.label),
							   tempTipo1  = retornaTipo($1.label),
							   tempLabel3 = retornaNome($3.label),
							   tempTipo3  = retornaTipo($3.label);

						if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

							erro = "Erro de Semântica na Linha : eu to no OP term and id" + to_string(linha);
							yyerror(erro);
						}

						else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

							$$.tipo_traducao = $1.traducao + tempLabel1 + " " + $2.label + " " + tempLabel3;
						}
					}
				}

				else{

					string tempLabel1 = retornaNome($1.label),
						   tempTipo1  = retornaTipo($1.label),
						   tempLabel3 = retornaNome($3.label),
						   tempTipo3  = retornaTipo($3.label);

					if ( verificaCast(tempTipo1,$2.label,tempTipo3) == -1 ){ // verifica se não é possivel fazer a operação devido aos tipos das variaveis

						erro = "Erro de Semântica na Linha : eu to no OP term and term" + to_string(linha);
						yyerror(erro);
					}

					else if(verificaCast(tempTipo1,$2.label,tempTipo3) == 0){// não precisa de cast implicito

						$$.tipo_traducao = $1.traducao + $3.traducao + tempLabel1 + " " + $2.label + " " + tempLabel3;
					}
				}
			}
			;

CAST 		: TK_CAST TK_ID
			{
				if ($1.label == "int"){ // Devo criar um temp novo para representar a variavel após o cast ou faço variavel=(int)variavel ?

					buscaMapa($2.label,0);

					if(verificaDeclaracao($2.label) == 1){

						mudaTipo($2.label,$1.label);
						string temp = retornaValor($2.label);
						int temp1 = atoi(temp.c_str());
						temp = to_string(temp1);
						alteraValor($2.label,temp);

						string tempLabel = retornaNome($2.label);
						$$.traducao = tempLabel + " = (" + $1.label + ") " + tempLabel + ";\n\n";
					}

					else if (verificaDeclaracao($2.label) == 0){

						erro = "Erro de Semântica na Linha : eu to no cast int" + to_string(linha);
						yyerror(erro);
					}
				}

				else if($1.label == "float"){ // Devo criar um temp novo para representar a variavel após o cast ou faço variavel=(float)variavel ?

					buscaMapa($2.label,0);

					if(verificaDeclaracao($2.label) == 1){

						mudaTipo($2.label,$1.label);
						string temp = retornaValor($2.label);
						temp = temp + ".0";
						alteraValor($2.label,temp);

						string tempLabel = retornaNome($2.label);
						$$.traducao = tempLabel + " = (" + $1.label + ") " + tempLabel + ";\n\n";
					}

					else if (verificaDeclaracao($2.label) == 0){

						erro = "Erro de Semântica na Linha : eu to no cast float" + to_string(linha);
						yyerror(erro);
					}
				}
			}
			;

IN 			:TK_IN '(' TK_ID ')'
			{

				buscaMapa($3.label,0);

				if($1.label == "cin"){

					if(verificaDeclaracao($3.label)==1){

						string tempLabel = retornaNome($3.label);
						$$.traducao = $1.traducao + $3.traducao + "\t"
						+ "cin >> " + tempLabel + ";\n\n";
					}

					if(verificaDeclaracao($3.label)==0){

						erro = "Erro de Semântica na Linha :eu to no cin " + to_string(linha);
						yyerror(erro);
					}
				}
			}
			;
			
OUT 		: TK_OUT '(' T ')'{

				if($3.tipo == "NULL"){

					erro = "Erro de Semântica na Linha :eu to no cin " + to_string(linha);
					yyerror(erro);
				}
				else{

					$3.label.erase($3.label.end() - 3, $3.label.end());
					$$.traducao = "cout << " + $3.label + ";\n\n";
				}
			}
			;

T 	 		: TK_STRING T
			{
				$$.label = $1.label + " << " + $2.label;
			}
			| TK_ID T{

				if(verificaDeclaracao($1.label)==1){

						string tempLabel = retornaNome($1.label);
						$$.label = tempLabel + " << " + $2.label;						
				}

				else if(verificaDeclaracao($1.label)==0){

						erro = "Erro de Semântica na Linha : vARIAVEL NÃO DECLARADA(T) " + to_string(linha);
						yyerror(erro);
				}
			}
			|
			{

				$$.tipo = "NULL";
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
