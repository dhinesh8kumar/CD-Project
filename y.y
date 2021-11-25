%{
#include<stdio.h>
#include<ctype.h>
%}
%token NUMBER INCLUDE LT GT HEADER VOID MAINFUNC COUT STRING INT ID ASSIGN IF ELSE WHILE FOR
%left '-' '+'
%left '*' '/'
%%
S : INCLUDE LT HEADER GT MAIN {printf("included");}
  ;
MAIN : VOID MAINFUNC BODY
     ;
BODY : '{' STMT_LT '}'
     ;
STMT_LT : STMT  STMT_LT  
         | 
         ;
STMT :  PRINT  {$$=$1;}
     | ASSIGN_EXP ';'
     | IF_STMT 
     | W
     | F
      ;


PRINT: COUT LT LT E ';' {$$ = $4;printf("%d",$4); }
| COUT LT LT STRING ';' {$$ = $4; printf("%s",$4);}
;

ASSIGN_EXP: ID ASSIGN E 
          | DT ID ASSIGN E 
          ;

DT : INT 
     ;

COMP: NUMBER GT NUMBER {if($1 > $3)
                        {
                            $$ = 1;
                        }
                        else
                        {
                            $$ = 0;
                        };}
| NUMBER LT NUMBER {if($1 < $3)
                        {
                            $$ = 1;
                        }
                        else
                        {
                            $$ = 0;
                        };}
;
IF_STMT: IF '(' COMP ')' '{' PRINT '}' ELSE '{' PRINT '}'  {if($3==1)
                                        {
                                             
                                           if(isdigit($6)==0){
                                                printf("%s",$6);
                                             
                                           }else{
                                                 printf("%d",$6);
                                           }
                                            
                                        }
                                        else
                                        {
                                            if(isdigit($10)==0){
                                              printf("%s",$10);
                                           }else{
                                                printf("%d",$10);
                                           }
                                        }
                                       ;}
 | IF '(' COMP ')' '{' PRINT '}' {
                                   if($3==1)
                                   {
                                             
                                           if(isdigit($6)==0){
                                                printf("%s",$6);
                                             
                                           }else{
                                                 printf("%d",$6);
                                           }
                                            
                                        }
 ;}
;

W: WHILE '(' NUMBER LT NUMBER ')' '{' PRINT '}' {
     int x = $3;
     int y = $5;
     while(x<y){
           if(isdigit($6)==0){
                                                printf("%s",$8);
                                             
                                           }else{
                                                 printf("%d",$8);
                                           }
     x++;
     }
;}
| WHILE '(' NUMBER GT NUMBER ')' '{' PRINT '}' {
     int x = $3;
     int y = $5;
     while(x>y){
           if(isdigit($6)==0){
                                                printf("%s",$8);
                                             
                                           }else{
                                                 printf("%d",$8);
                                           }
     x--;
     }
;}
;

F: FOR '(' INT ID ASSIGN NUMBER ';' ID LT NUMBER ';' ID '+' '+' ')' '{' PRINT '}' {
        int i;
        for(i=$6;i<$10;i++){
              printf("%s",$17);
          }
          printf("for i in range(0,$10) )
     ;}
| FOR '(' INT ID ASSIGN NUMBER ';' ID GT NUMBER ';' ID '-' '-' ')' '{' PRINT '}' {
        int i;
        for(i=$6;i>$10;i--){
              printf("%s",$17);
          }
     ;}  



E: E '+' E { $$ = $1 + $3; }
| E '-' E { $$ = $1 - $3; }
| E '*' E { $$ = $1 * $3; }
| E '/' E { if($3 == 0)yyerror("Divide by zero");else$$ = $1 / $3; }
| '(' E ')' { $$ = $2; }
| NUMBER { $$ = $1; }
;

%%
int main(){
yyparse();
}
int yywrap(){
return 1;
}
int yyerror(char *s){
printf("Error %s",s);
exit(0);
return 0;
}