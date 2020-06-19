/*
3D Building Rendering: lexer.l
Zachariah Menzie - made 2/6/2020

Format:
control info
%%
token/grammar definitions
%%
C code

DEBUGGING: (POTENTIAL ERRORS)
1. Error: Syntax Error
	- This error can occur when bison does not find a single pattern from the text file flex is reading from.
2. 

*/

/* C code calls---------------------------------------------- */

%defines "parser.h"

%{

	#include <cstdio>
	#include <iostream>
	#include "GLWidget3D.h"
	#include "Building.hpp"
	using namespace std;	
	

	// Declare functions lex and bison both need:
	extern int yylex(); // lexical analyzer
	 
	// Function coded in section 3:
	extern void yyerror(const char * s);

	

%}

%union {

	int ival;
	float fval;
	char * sval;
	const char * constchar;

}

%token <ival> INTEGER
%token <sval> STRING
%token <fval> FLOATVALUE

%token <constchar> MERGE

%token <constchar> BLOCKSPLIT
%token <constchar> MULTIBLOCKSPLIT
%token <constchar> SURFACESPLIT
%token <constchar> MULTISURFACESPLIT

%token <constchar> SETCOLOR
%token <constchar> SETNAME
%token <constchar> SETTEXTURE
%token <constchar> MAKEGROUP
%token <constchar> INSERT
%token <constchar> COMMENTBEGIN
%token <constchar> COMMENTEND

%token <constchar> PARENBEGIN
%token <constchar> PARENEND
%token <constchar> CURLYBEGIN
%token <constchar> CURLYEND
%token <constchar> PLUSPLUS
%token <constchar> IDENTIFER_FOR
%token <constchar> IDENTIFER_IF
%token <constchar> EQUAL
%token <constchar> TYPE_INT


%%	/* Token/Grammar section cannot be empty: otherwise error */

renderBuilding:
	commands
	;

commands:
	build
	;

build:
	build STRING STRING STRING FLOATVALUE FLOATVALUE FLOATVALUE FLOATVALUE FLOATVALUE FLOATVALUE {
		cout << $2 << " created";
		bldg->createBox($2, $4, $5, $6, $7, $8, $9, $10);
	}
	| STRING STRING STRING FLOATVALUE FLOATVALUE FLOATVALUE FLOATVALUE FLOATVALUE FLOATVALUE {
		cout << $1 << " created";
		bldg->createBox($1, $3, $4, $5, $6, $7, $8, $9);
	}


	| build STRING MERGE STRING STRING {
		cout << "Merge: " << $4 << ", " << $5 << " -> " << $2 << endl;
		bldg->merge($2, $4, $5);
	}
	| STRING MERGE STRING STRING {
		cout << "Merge: " << $3 << ", " << $4 << " -> " << $1 << endl;
		bldg->merge($1, $3, $4);
	}


	| build STRING STRING SURFACESPLIT STRING STRING STRING FLOATVALUE {
		cout << "\nSurface Split detected" << endl;
		bldg->surfaceSplit($2, $3, $5, $6, $7, $8);
	}
	| STRING STRING SURFACESPLIT STRING STRING STRING FLOATVALUE {
		cout << "Surface Split detected" << endl;
		bldg->surfaceSplit($1, $2, $4, $5, $6, $7);
	}

	| build STRING STRING SURFACESPLIT STRING STRING STRING STRING FLOATVALUE {
		cout << "\nSurface Split detected" << endl;
		bldg->surfaceSplit($2, $3, $5, $6, $7, $8, $9);
	}
	| STRING STRING SURFACESPLIT STRING STRING STRING STRING FLOATVALUE {
		cout << "Surface Split detected" << endl;
		bldg->surfaceSplit($1, $2, $4, $5, $6, $7, $8);
	}

	| build MAKEGROUP STRING {
		cout << "New Group: " << $3 << endl;
		bldg->makeGroup($3);
	}
	| MAKEGROUP STRING {
		cout << "New Group: " << $2 << endl;
		bldg->makeGroup($2);
	}


	| build STRING INSERT STRING {
		cout << $4 << " added to group " << $2 << endl;
		bldg->groupInsert($2, $4);
	}
	| STRING INSERT STRING {
		cout << $3 << " added to group " << $1 << endl;
	    bldg->groupInsert($1, $3);
	}


	| build SETTEXTURE STRING STRING STRING {
		cout << "Texture applied: " << $5 << endl;
		bldg->setTexture($3, $4, $5);
	}
	| SETTEXTURE STRING STRING STRING {
		cout << "Texture applied: " << $4 << endl;
		bldg->setTexture($2, $3, $4);
	}


	| build STRING SETNAME STRING STRING {
		cout << "New Name: " << $2 << endl;
		bldg->setName($2, $4, $5);
	}
	| STRING SETNAME STRING STRING {
		cout << "New Name: " << $1 << endl;
		bldg->setName($1, $3, $4);
	}


	| build SETCOLOR STRING STRING STRING FLOATVALUE FLOATVALUE FLOATVALUE {
		cout << "New Color: " << $5 << ", " << $6 << ", " << $7 << endl;
		bldg->setColor($3, $4, $5, $6, $7, $8);
	}
	| SETCOLOR STRING STRING STRING FLOATVALUE FLOATVALUE FLOATVALUE {
		cout << "New Color: " << $4 << ", " << $5 << ", " << $6 << endl;
		bldg->setColor($2, $3, $4, $5, $6, $7);
	}
	
	| build COMMENTBEGIN COMMENTEND {
		cout << "Empty Comment detected" << endl;
	}
	| COMMENTBEGIN COMMENTEND {
		cout << "Empty Comment detected" << endl;
	}
	| build COMMENTBEGIN message COMMENTEND {
		cout << "*/" << endl;
	}
	| COMMENTBEGIN message COMMENTEND {
		cout << "*/" << endl;
	}
;

message:
	message STRING {

	}
	| STRING {

	}
;




%%
