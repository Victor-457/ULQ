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
STRING \"([^\"\n]|\\\")*\"

%%

"\n"		{linha++;}

{DELIM} 	{}

"qualquer main"		{return TK_MAIN;}

"int"		{yylval.label = "int";return TK_TIPO;}

"real"		{yylval.label = "float";return TK_TIPO;}

"char"		{yylval.label = "char";return TK_TIPO;}

"bool"		{yylval.label = "bool";return TK_TIPO;}

"string"	{yylval.tipo = "string"; return TK_TIPO_STRING; }

"qualquer"	{yylval.label = "";return TK_TIPO_VAR;}

"+"			{yylval.label = "+";return TK_ADD_SUB;}

"-"			{yylval.label = "-";return TK_ADD_SUB;}

"*"			{yylval.label = "*";return TK_MULT_DIV_RES;}

"/"			{yylval.label = "/";return TK_MULT_DIV_RES;}

"%"			{yylval.label = "%";return TK_MULT_DIV_RES;}

"<"			{yylval.label = "<";return TK_REL;}

">"			{yylval.label = ">";return TK_REL;}

"=="		{yylval.label = "==";return TK_REL;}

"<="		{yylval.label = "<=";return TK_REL;}

">="		{yylval.label = ">=";return TK_REL;}

"!="		{yylval.label = "!=";return TK_REL;}

"and"		{yylval.label = "and";return  TK_LOGIC;}

"or"		{yylval.label = "or";return  TK_LOGIC;}

"not"		{yylval.label = "not";return  TK_NOT;}

"="			{yylval.label = "=";return TK_ATRIBUICAO;}

"castI"		{yylval.label = "int";return TK_CAST;}

"castR"		{yylval.label = "float";return TK_CAST;}

"que?!"		{yylval.label = "cin";return TK_IO;}

"puts"		{yylval.label = "cout";return TK_IO;}

"if"		{yylval.label = "if";return TK_COND;}

"while" 	{yylval.label = "while";return TK_LOOP;}

"for" 		{yylval.label = "for";return TK_COND;}

"else"	 	{yylval.label = "else";return TK_COND;}

"else if"   {yylval.label = "else if";return TK_COND;}

"do" 		{yylval.label = "do";return TK_LOOP;}

"{"		    {empilhaNovoMapa();return *yytext;}

"}"     	{return *yytext;}

[()[\];,]	{ return *yytext; }


true|false	{ yylval.label = yytext; yylval.tipo = "boolean" ;return TK_BOOLEAN;}
{INT}		{ yylval.label = yytext; yylval.tipo = "int" ;return TK_INT; }

{STRING}  	{   string texto = yytext;		
				texto.replace(texto.begin(), texto.begin() + 1, "");
				texto.replace(texto.end() - 1, texto.end(), "");
				yylval.traducao = texto;
				yylval.label = texto;
				yylval.tipo = "string";
				yylval.tipo_traducao = "char";
				yylval.tamanho = strlen(yytext);
				return TK_STRING;
}
{REAL}		{ yylval.label = yytext; yylval.tipo = "float"; return TK_REAL;}
{ID}		{ yylval.label = yytext; yylval.tipo = "id"; return TK_ID; }
{CHAR}		{ yylval.label = yytext; yylval.tipo = "char"; return TK_CHAR; }

.			{ *yytext; }

%%
