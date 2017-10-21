%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]


DELIM {ESPACO}+
INT {DIGITO}+

REAL {INT}+("."{INT}+)?
boolean [true|false]
CHAR \'({LETRA}|{INT})\'
ID {LETRA}({LETRA}|{INT})*


%%

"\n"		{linha++;}

{DELIM} 	{}

"main"		{return TK_MAIN;}

"int"		{return TK_TIPO_INT;}

"real"		{return TK_TIPO_REAL;}

"id"		{return TK_TIPO_ID;}

"char"		{return TK_TIPO_CHAR;}

"bool"		{return TK_TIPO_BOOLEAN;}

"%"			{return TK_RESTO;}

"<"			{return TK_MENOR;}

">"			{return  TK_MAIOR;}

"=="		{return  TK_IGUAL;}

"<="		{return  TK_MENOR_IGUAL;}

">="		{return  TK_MAIOR_IGUAL;}

"!="		{return  TK_DIFERENTE;}

"and"		{return  TK_AND;}

"or"		{return  TK_OR;}

"not"		{return  TK_NOT;}

"="			{return TK_ATRIBUICAO;}

"castI"		{return TK_CAST_INT;}

"castR"		{return TK_CAST_FLOAT;}

"que?!"		{return TK_CIN;}

"puts"		{return TK_COUT;}

"if"		{return TK_IF;}

"while" 	{return TK_WHILE;}

"for" 		{return TK_FOR;}

"else"	 	{return TK_ELSE;}

"else if"   {return TK_ELSE_IF;}

"do" 		{return TK_DO;}

"fimI"		{return TK_FIM_IF;}

"fimF" 		{return TK_FIM_FOR;}

"fimW" 		{return TK_FIM_WHILE;}

"fimEI"		{return TK_FIM_ELSE_IF;}

"fimE"		{return TK_FIM_ELSE;}

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }


true|false	{ yylval.label = yytext; yylval.tipo = "boolean" ;return TK_BOOLEAN;}
{INT}		{ yylval.label = yytext; yylval.tipo = "int" ;return TK_INT; }

{REAL}		{ yylval.label = yytext; yylval.tipo = "float"; return TK_REAL;}
{ID}		{ yylval.label = yytext; yylval.tipo = "id"; return TK_ID; }
{CHAR}		{ yylval.label = yytext; yylval.tipo = "char"; return TK_CHAR; }
.			{ *yytext; }

%%
