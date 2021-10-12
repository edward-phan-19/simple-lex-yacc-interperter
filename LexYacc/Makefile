all: lex.l yacc.y
	lex -o lex.yy.c lex.l
	yacc -d yacc.y
	gcc y.tab.c lex.yy.c -lm -ll -o string_lang

clean:
	rm *.c 
	rm *.h 