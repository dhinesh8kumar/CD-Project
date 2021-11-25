%{
#include "y.tab.h"
%}
%%
[ \t\n] {yylval = strdup(yytext);}
[0-9]+ {yylval=atoi(yytext);return NUMBER;}
"#include" {yylval=strdup(yytext);return INCLUDE;}
"<" {yylval=strdup(yytext);return LT;}
">" {yylval=strdup(yytext);return GT;}
"="     {yylval = strdup(yytext);return ASSIGN;}
"iostream.h" {yylval=strdup(yytext);return HEADER;}
"void" {yylval=strdup(yytext);return VOID;}
"main()" {yylval=strdup(yytext);return MAINFUNC;}
"cout" {yylval=strdup(yytext);return COUT;}
"int" {yylval = strdup(yytext);return INT;}
"if" {yylval = strdup(yytext);return IF;}
"else" {yylval = strdup(yytext);return ELSE;}
"while" {yylval = strdup(yytext);return WHILE;}
"for" {yylval = strdup(yytext);return FOR;}
[a-zA-Z_]*[0-9]? {yylval=strdup(yytext);return ID;}
\".*\" {yylval=strdup(yytext);return STRING;}  
. return yytext[0];
%%