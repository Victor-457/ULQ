%{
#include <string>

%}

ESPACO [ \t]
DELIM {ESPACO}+

DIGITO [0-9]
LETRA [A-Za-z_]

TRUE [1]
FALSE [0]

INT {DIGITO}+
FLOAT {INT}+("."{INT}+)?

CHAR \'({LETRA}|{NUM})\'

BOOL ({TRUE}|{FALSE})

ID {LETRA}({LETRA}|{INT})*

%%

"\n"		{}
{DELIM} 	{}

"main"		{return TK_MAIN;}
"int"		{return TK_TIPO_INT;}

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }

/* pelo que eu vi o yytext retorna uma string ou um char não sei bem qual ( mas tenho 
   quase certeza de que é uma string), então pelo q eu vi deve se usar a função atoi 
   para conversão para inteiros e a atof para conversão para float. Fazendo isso ficaria
   igual ta aqui em baixo ( OBS: desse jeito o lex compila ).
   
   FONTE: http://aquamentus.com/tut_lexyacc.html

   O que não sei se está correto é o yylval.label receber o retorno do yytext, pq no arquivo 
   do yacc o label recebe o nome da variavel então meio q o retorno se perde não sei explicar direito 
   o que to querendo dizer.
   Acho que aqui em baixo em vez do label receber quem deveria receber é a tradução
*/

{NUM}		{ yylval.label = atoi(yytext); return TK_NUM; }
{FLOAT}		{ yylval.label = atof(yytext); return TK_FLOAT; }

{CHAR}      { yylval.label = yytext; return TK_CHAR; }
{BOOL}		{ yylval.label = yytext; return TK_BOOL; }
{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
