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

CHAR \'({LETRA}|{INT})\'

BOOL ({TRUE}|{FALSE})

ID {LETRA}({LETRA}|{INT})*

%%

"\n"		{}

{DELIM} 	{}

"main"		{return TK_MAIN;}

"int"		{return TK_TIPO_INT;}

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }

{INT}		{ yylval.label = atoi(yytext); return TK_INT; }
{FLOAT}		{ yylval.label = atof(yytext); return TK_FLOAT; }

{CHAR}      { yylval.label = yytext; return TK_CHAR; }
{BOOL}		{ yylval.label = yytext; return TK_BOOL; }
{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
