%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

// Define getch function for Unix-like systems
#ifdef unix
#include <unistd.h>
#define getch() getchar()
#endif

int flag=0;
%}

%token NUMBER PRINT WHITESPACE NEWLINE EXIT HELP STRING ORDERSTART ORDEREND
%token IF THEN ELSE GT LT EQ GE LE NE AND OR EXOR ADD SUB MUL DIV MOD ANDAND OROR
%left ADD SUB
%left MUL DIV MOD
%left ORDERSTART ORDEREND
%%

COMMAND: {printf("$ ");} Expression1 ;

Expression1: errorPrint
            | exit
            | printString 
            | printNumber
            | help
            | ifCondition 
            | ifElseCondition 
            | E 
            ;

errorPrint: STRING NEWLINE 
        {
            printf("Error encountered: %s\n", $1);
            printf("Seeking Assistance\n\n");
        } COMMAND;

exit: EXIT NEWLINE 
        {
            printf("\nGoodbye Chef! Remember, practice makes perfect.\n");
            exit(0);
        };

printString: PRINT WHITESPACE STRING NEWLINE 
                                        {
                                             printf("Displaying string: %s\n", $3);
                                        } COMMAND;

printNumber: PRINT WHITESPACES E NEWLINE 
                                        {
                                            printf("Displaying number: %d\n", $3); 
                                        } COMMAND;

WHITESPACES: WHITESPACE WHITESPACES | ;

ifCondition: IF ORDERSTART CONDITION ORDEREND WHITESPACE THEN WHITESPACE Expression1 NEWLINE{
    if($3)
    {
        printf("Condition met: %d\n",$8); 
    }
    else
    {
        printf("Condition not met. Moving on.\n");
    }
} COMMAND;

ifElseCondition: IF ORDERSTART CONDITION ORDEREND WHITESPACE THEN WHITESPACE Expression1 WHITESPACE ELSE WHITESPACE Expression1 NEWLINE {
    if($3)
    {
        printf("Condition met: %d\n",$8); 
    } 
    else 
    {
        printf("Condition not met: %d\n",$12);
    }
} COMMAND;

help: HELP NEWLINE
                { 
                    printf("Welcome to the Chef language guide!\n");
                    printf("To print a string or number, use the PRINT command.\n");
                    printf("For arithmetic operations, use +, -, *, /, %, &, |, ^, and parentheses for grouping.\n");
                    printf("To check conditions, use >, <, ==, >=, <=, !=, and logical operators MIX WELL and BLEND THOROUGHLY.\n");
                    printf("For conditional execution, use IF, THEN, and optionally ELSE.\n");
                    printf("To seek help, use the HELP command.\n");
                    printf("To exit, use the BYE CHEF command.\n");
                } COMMAND;

E:E ADD E {$$=$1+$3;}
|E SUB E {$$=$1-$3;}
|E MUL E {$$=$1*$3;}
|E DIV E {$$=$1/$3;}
|E MOD E {$$=$1%$3;}
|ORDERSTART E ORDEREND {$$=$2;}
|E AND E {$$=$1&$3;}
|E OR E {$$=$1|$3;}
|E EXOR E {$$=$1^$3;}
| NUMBER {$$=$1;}
;

CONDITION:E GT E {$$ = $1>$3;}
|   E LT E {$$ = $1 < $3;}
|   E EQ E {$$ = ($1 == $3);}
|   E GE E {$$ = ($1 >= $3);}
|   E LE E {$$ = ($1 <= $3);}
|   E NE E {$$ = ($1 != $3);}
|   CONDITION WHITESPACE ANDAND WHITESPACE CONDITION {$$ = ($1 && $3);}
|   CONDITION WHITESPACE OROR WHITESPACE CONDITION {$$ = ($1 || $3);}
|   E {$$ = $1;}
;

%%

void main()
{
    printf("\nHello Chef\n");
    yyparse();
}

void yyerror(const char *s)
{
   fprintf(stderr, "Error: %s\n", s);
}