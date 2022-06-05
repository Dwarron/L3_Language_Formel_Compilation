/*
Groupe 4:
BALDE Abdoul Gadiry
ROUSSELET Quentin
PINON Alexandre

troisieme colone :
titre=1
normal=2
item=3

CTLR+d POUR QUITTER
*/

%{
#include <stdio.h>
#include <string.h>

#include "y.tab.h"

int indexTab = 0, position = 0, i, j;
char CH[500];
int TAB[5][50];
%}

MORCTXT (([A-Za-z]|[^*_" "#\n])+(" "+)?)*
BALISETITRE ^" "{0,3}"#"{1,6}" "+
FINTITRE ("\n"(" "+)?"\n"|("\n")|(" "+"\n"))
LIGNEVIDE "\n"(" "+)?"\n"
DEBUTLISTE ^"*"" "+
ITEMLISTE ^"*"" "+
FINLISTE "\n"(" "+)?"\n"
ETOIL "*"
DEFAULT (" "+)|("\t"+)
RETOURLIGNE (("\n")|(" "+"\n"))

%start ITEM
%start TITRE

%%

{DEFAULT} {printf("");}

<INITIAL>{BALISETITRE} {
	printf("Balise de titre\n");

	BEGIN TITRE;

	return BALTIT;
}

<TITRE>{MORCTXT} {
	printf("Morceau de texte : %s\n", yytext);
	strcat(CH, yytext);

	TAB[0][indexTab]=indexTab;
	TAB[1][indexTab]=position;
	TAB[2][indexTab]=yyleng;
	TAB[3][indexTab]=1;
	indexTab++;
	position=position+yyleng;

	return TXT;
}

<TITRE>{FINTITRE} {
	printf("Fin de titre \n");

	BEGIN INITIAL;

	return FINTIT;
}

<INITIAL>{DEBUTLISTE} {
	printf("Début de liste\n");

	BEGIN ITEM;

	return DEBLIST;
}

<ITEM>{MORCTXT} {
	printf("Morceau de texte : %s\n", yytext);
	strcat(CH, yytext);

	TAB[0][indexTab]=indexTab;
	TAB[1][indexTab]=position;
	TAB[2][indexTab]=yyleng;
	TAB[3][indexTab]=3;
	indexTab++;
	position=position+yyleng;

	return TXT;
}

<ITEM>{ITEMLISTE} {
	printf("Item de liste\n");

	return ITEMLIST;
}

<ITEM>{FINLISTE} {
	printf("Fin de liste\n");

	BEGIN INITIAL;

	return FINLIST;
}

{LIGNEVIDE} {
	printf("Ligne vide \n");

	return LIGVID;
}

{ETOIL} {
	printf("Etoile \n");

	return ETOILE;
}

{MORCTXT} {
	printf("Morceau de texte : %s\n", yytext);
	strcat(CH, yytext);

	TAB[0][indexTab]=indexTab;
	TAB[1][indexTab]=position;
	TAB[2][indexTab]=yyleng;
	TAB[3][indexTab]=2;
	indexTab++;
	position=position+yyleng;

	return TXT;
}

{RETOURLIGNE} {printf("");}

. {
	printf("Erreur lexicale : Caractère %s non autorisé\n", yytext);
}

%%

int yywrap() {
	printf("%s\n", CH);
	for(i = 0; i < 50; i++)
	{
		if (i > 0 && TAB[0][i] == 0)
			return 1;

		for(j = 0; j < 3; j++)
		{
			printf("%4d",TAB[j][i]);
		}

		if (TAB[3][i] == 1)
			printf("  Titre");
		else if (TAB[3][i] == 2)
		  printf("  Normal");
		else
		  printf("  Item");

		printf("\n");
	}
	return 1;
}
