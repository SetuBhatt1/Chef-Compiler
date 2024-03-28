%{
/* Definition section */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern int yylval;
%}

HELP "HELP"
PRINT "PRINT"
WHITESPACE " "
IF "IF"
THEN "THEN"
GT ">"
LT "<"
EQ "=="
GE ">="
LE "<="
NE "!="
NEWLINE "\n"
EXIT "BYE CHEF"
ADD "+"
SUB "-"
MUL "*"
DIV "/"
MOD "%"
AND "&"
ANDAND "MIX WELL"
OROR "BLEND THOROUGHLY"
OR "|"
EXOR "^"
ORDERSTART "("
ORDEREND ")"
NUMBER [0-9]+
STRING [A-Za-z0-9]+
/* Rule Section */
%%

{HELP} {
    return HELP;
}

{ADD} {
    return ADD;
}

{SUB} {
    return SUB;
}

{MUL} {
    return MUL;
}

{DIV} {
    return DIV;
}

{MOD} {
    return MOD;
}

{AND} {
    return AND;
}

{OR} {
    return OR;
}

{ANDAND} {
    return ANDAND;
}

{OROR} {
    return OROR;
}

{EXOR} {
    return EXOR;
}

{PRINT} {
    return PRINT;
}

{WHITESPACE} {
    return WHITESPACE;
}

{NEWLINE} {
    return NEWLINE;
}

{EXIT} {
    return EXIT;
}

{IF} {
    return IF;
}

{THEN} {
    return THEN;
}

{GT} {
    return GT;
}

{LT} {
    return LT;
}

{EQ} {
    return EQ;
}

{GE} {
    return GE;
}

{LE} {
    return LE;
}

{NE} {
    return NE;
}

{ORDERSTART} {
    return ORDERSTART; 
}

{ORDEREND} {
    return ORDEREND;
}

{NUMBER} {
    yylval = atoi(yytext);
    return NUMBER;
}

{STRING} {
    yylval = strdup(yytext); // Use strdup to allocate memory and copy the string
    return STRING;
}

. return yytext[0];

%%

int yywrap() {
    return 1;
}