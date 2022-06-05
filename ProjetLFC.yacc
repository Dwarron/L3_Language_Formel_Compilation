%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror (char * s);
%}

%token TXT
%token BALTIT
%token FINTIT
%token LIGVID
%token DEBLIST
%token ITEMLIST
%token FINLIST
%token ETOILE

%type fichier
%type element
%type titre
%type liste
%type suite_liste
%type texte_formatte
%type liste_textes

%start fichier

%%

fichier: element
  | element fichier;

element: TXT 
  | LIGVID
  | titre
  | liste
  | texte_formatte;

titre: BALTIT TXT FINTIT

liste: DEBLIST liste_textes suite_liste

suite_liste: ITEMLIST liste_textes suite_liste
  | FINLIST;

texte_formatte: italique
  | gras
  | grasitalique;

italique: ETOILE TXT ETOILE

gras: ETOILE ETOILE TXT ETOILE ETOILE

grasitalique: ETOILE ETOILE ETOILE TXT ETOILE ETOILE ETOILE

liste_textes: TXT
  | texte_formatte
  | TXT liste_textes
  | texte_formatte liste_textes;

%%
int main()
{
  yyparse(); //permet d'appeler yylex()
  yylex();
  return 0;
}

void yyerror (char * s)
{
  fprintf(stderr, "erreur %s\n", s);
}
