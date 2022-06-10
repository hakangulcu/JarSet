parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315s22_team20.y
	yacc CS315s22_team20.y
lex.yy.c: CS315s22_team20.l
	lex CS315s22_team20.l
