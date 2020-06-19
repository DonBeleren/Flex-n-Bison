/*
3D Building Rendering: lexer.l
Zachariah Menzie - made 2/6/2020

Format:
Section 1-control info
%%
Section 2-token/grammar definitions
%%
Section 3-C code

RULES:
1. Do not put comments on the same line as curly braces{}
2. Do not put comments in section 2
3. Section 2 can never be empty

*/

/* C code calls---------------------------------------------- */

/* Prevent flex from trying to use the yywrap function (not necessary) */
%option noyywrap

%top{ 
	
	#include <cstdio>
	#include <iostream>

	using namespace std;
	#include "parser.h"

	void showError();

}

%%	/* Token/Grammar section cannot be empty: otherwise error */

[ \t]			;
[0-9]+			{ yylval.ival = atoi(yytext); return INTEGER; }
[0-9]+\.[0-9]+	{ yylval.fval = atof(yytext); return FLOATVALUE; }

"blockSplit"			    { yylval.sval = strdup(yytext); return BLOCKSPLIT; }
"multiBlockSplit"			{ yylval.sval = strdup(yytext); return MULTIBLOCKSPLIT; }
"surfaceSplit"			    { yylval.sval = strdup(yytext); return SURFACESPLIT; }
"multiSurfaceSplit"			{ yylval.sval = strdup(yytext); return MULTISURFACESPLIT; }

"merge"			{ yylval.sval = strdup(yytext); return MERGE; }

"setName"			{ yylval.sval = strdup(yytext); return SETNAME; }
"setColor"			{ yylval.sval = strdup(yytext); return SETCOLOR; }
"setTexture"		{ yylval.sval = strdup(yytext); return SETTEXTURE; }
"makeGroup"		{ yylval.sval = strdup(yytext); return MAKEGROUP; }
"insert"		{ yylval.sval = strdup(yytext); return INSERT; }
"/*"			{ yylval.sval = strdup(yytext); return COMMENTBEGIN; }
"*/"			{ yylval.sval = strdup(yytext); return COMMENTEND; }

"int"		{ yylval.sval = strdup(yytext); return TYPE_INT; }
"="			{ yylval.sval = strdup(yytext); return EQUAL; }
"++"		{ yylval.sval = strdup(yytext); return PLUSPLUS; }
"for"		{ yylval.sval = strdup(yytext); return IDENTIFER_FOR; }
"if"		{ yylval.sval = strdup(yytext); return IDENTIFER_IF; }
"("			{ yylval.sval = strdup(yytext); return PARENBEGIN; }
")"			{ yylval.sval = strdup(yytext); return PARENEND; }
"{"			{ yylval.sval = strdup(yytext); return CURLYBEGIN; }
"}"			{ yylval.sval = strdup(yytext); return CURLYEND; }


[a-zA-Z0-9]+	{ yylval.sval = strdup(yytext); return STRING; }


.				{}

%% /* C code------------------------------------------*/

void showError() {}


