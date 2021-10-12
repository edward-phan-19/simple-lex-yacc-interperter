
%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    char* sym[100];
    char c;

   extern void yyerror();
   extern int yylex();
   extern char* yytext;
   extern int yylineno;
%}


%union 
{
 char* string;
 int variable;
}

%token  EQUALS FIRST REST CONS PRINT WHITE

%token <variable> VAR 
%token <string>   STRING


%%
  program:
    program statement '\n'
    |
    ;

  statement: PRINT VAR                       {printf("%s\n", sym[$2]);}
           | VAR '=' STRING                  {sym[$1] = $3;}    
           | VAR '=' FIRST VAR               {c = (sym[$4][0]);sym[$1] = &c;}
           | VAR '=' REST VAR                {sym[$1] = sym[$4] + 1;}
           | VAR '=' CONS VAR VAR            {sym[$1] = strcat(sym[$4], sym[$5]);}
           ;
           



  
%%

int main(int argc, char **argv)
{
  extern FILE *yyin;
  yyin = fopen(argv[1], "r"); //sets up lexer to use this file as input
  yyparse(); 
  return 0; 
  fclose(yyin);  
}