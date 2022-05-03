%option noyywrap
%option yylineno noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int line = 1;
enum Token {
    INT=258, FLOAT, VOID, CONST, RETURN, IF, ELSE, FOR, WHILE, DO, BREAK, CONTINUE,
    LP, RP, LB, RB, LC, RC, COMMA, SEMICOLON, QUESTION, COLON,
    MINUS, NOT, TILDE, ASSIGN, ADD, MUL, DIV, MOD, AND, OR,
    EQ, NE, LT, LE, GT, GE,
    ID, INT_LIT, FLOAT_LIT,
    LEX_ERR
};

%}
DIGIT [0-9]
LETTER [a-zA-Z]
ID ({LETTER}|_)({LETTER}|_|{DIGIT})*
OINTEGER [1-9]{DIGIT}*
LEX_ERR ("0")[8-9][0-9]|[0-9][a-zA-Z]+[0-9]+|[0-9][a-zA-Z]
FLOAT [0-9]+[Ee]([+-]?[0-9]([0-9])*|[0])[f]
HINT ("0x")[0-9a-f]+
EINT ("0")[0-7]+
DBPS \/\*(.|\n)*\*\/ 
SGPS \/\/.*

%%
\n {++line;}
")" {printf("%s : RP\n", yytext); return RP; }
"(" {printf("%s : LP\n", yytext); return LP; }
"{" {printf("%s : LC\n", yytext); return LC; }
"}" {printf("%s : RC\n", yytext); return RC; }
"]" {printf("%s : RB\n", yytext); return RB; }
"[" {printf("%s : LB\n", yytext); return LB; }
"," {printf("%s : COMMA\n", yytext); return COMMA; }
";" {printf("%s : SEMICOLON\n", yytext); return SEMICOLON; }
"?" {printf("%s : QUESTION\n", yytext); return QUESTION; }
":" {printf("%s : COLON\n", yytext); return COLON; }
"!" {printf("%s : NOT\n", yytext); return NOT; }
"==" {printf("%s : EQ\n", yytext); return EQ; }
"=" {printf("%s : ASSIGN\n", yytext); return ASSIGN; }
"-" {printf("%s : MINUS\n", yytext); return MINUS; }
"+" {printf("%s : ADD\n", yytext); return ADD; }
"*" {printf("%s : MUL\n", yytext); return MUL; }
"/" {printf("%s : DIV\n", yytext); return DIV; }
"<" {printf("%s : LT\n", yytext); return LT; }
">" {printf("%s : GT\n", yytext); return GT; }
"int" {printf("%s : INT\n", yytext); return INT; }
"float" {printf("%s : FLOAT\n", yytext); return FLOAT; }
"void" {printf("%s : VOID\n", yytext); return VOID; }
"const" {printf("%s : CONST\n", yytext); return CONST; }
"return" {printf("%s : RETURN\n", yytext); ; return RETURN; }
"if" {printf("%s : IF\n", yytext); return IF; }
"else" {printf("%s : ELSE\n", yytext); return ELSE; }
"for" {printf("%s : FOR\n", yytext); return FOR; }
"while" {printf("%s : WHILE\n", yytext); return WHILE; }
"do" {printf("%s : DO\n", yytext); return DO; }
"break" {printf("%s : BREAK\n", yytext); return BREAK; }
"continue" {printf("%s : CONTINUE\n", yytext); return CONTINUE; }
{LEX_ERR} {printf("Lexical error - line %d : %s\n", line, yytext); return LEX_ERR; } 
{HINT} {printf("%s : INT_LIT\n", yytext); return INT_LIT; } 
{ID} {printf("%s : ID\n", yytext); return ID; } 
{EINT} {printf("%s : INT_LIT\n", yytext); return INT_LIT; }
{DIGIT} {printf("%s : INT_LIT\n", yytext); return INT_LIT; } 
{FLOAT} {printf("%s : FLOAT_LIT\n", yytext); return FLOAT_LIT; } 
{OINTEGER} {printf("%s : INT_LIT\n", yytext); return INT_LIT; } 
{SGPS} {}
{DBPS} {
    for(int i=0;yytext[i];i++)
    {
        if(yytext[i]=='\n')
        {
            line++;
        }
    }
}
[ \t]+ {}
. {}


%%


int main(int argc, char** argv) {
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
           perror(argv[1]); 
           return  1; 
        }
        while(yylex())
        {

        }   





        fclose(yyin);
    } else printf("No source file given!\n"); 

    return 0; 
}