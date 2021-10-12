%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "y.tab.h"
  void extern yyerror(char*);
  void InvalidToken();
%}

linefeed     \n
whitespace	 [ \t\r\v\f]
variable	   [X][1-9][0-9]* 	        

%%

CONS			      return CONS;
REST			      return REST;
FIRST			      return FIRST;
PRINT           return PRINT;

[-+()=/*]       {return *yytext;}
\n              {yylineno++; return *yytext; }
[ \t]           ;


{variable}        {
                    yylval.variable = atoi(yytext+1);
                    return VAR;
                  } 

[a-zA-Z]+   {
                    yylval.string = strdup(yytext);
                    return STRING;
                  }

.			            printf("Incorrect syntax\n");
%%


  int yywrap(void)
  {
    return 1;
  }

  void yyerror(char *s)
  {
    fprintf(stderr,"\nERROR ON LINE %d : \n %s ", yylineno, s);
    exit(0);
  }

  void InvalidToken()
  {
    printf("ERROR ON LINE %d : \n Invalid Token %s\n", yylineno,yytext);
    exit(0);
  }
