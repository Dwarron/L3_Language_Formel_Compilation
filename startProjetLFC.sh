#!/bin/bash

yacc ProjetLFC.yacc
yacc -d ProjetLFC.yacc
lex -v ProjetLFC.lex
gcc -Wall -c lex.yy.c
gcc -Wall y.tab.c lex.yy.o -lfl -o ProjetLFC
./ProjetLFC
