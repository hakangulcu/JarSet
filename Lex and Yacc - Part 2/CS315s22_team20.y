%{
#include <stdio.h>
#include <stdlib.h>
%}
%token	COMMENT
%token	PRINT
%token	PRINTF
%token	PRINTSET
%token	CONTINUE
%token	STOP
%token	FUNCTION_DEFINE
%token	FUNCTION_OPERATOR
%token	SET_IDENTIFIER
%token	SET_ELEMENT
%token	INT
%token	FLOAT
%token	STRING
%token	AT
%token	ASSIGNMENT_OPERATOR
%token	LP
%token	RP
%token	LCB
%token	RCB
%token	COMMA
%token 	COLON
%token	BOOLEAN
%token	NONE
%token	END
%token	AND
%token	OR
%token	IS_EQUAL
%token	NOT_EQUAL
%token	SMALLER_THAN
%token	GREATER_THAN
%token	SMALLER_THAN_OR_EQUAL
%token	GREATER_THAN_OR_EQUAL
%token	SET_INTERSECTION
%token	SET_UNION
%token	SET_DIFFERENCE
%token	SET_COMPLEMENT
%token	SET_CARTESIAN
%token	CREATE_SET
%token	DELETE_SET
%token	SUBSET
%token	SUPERSET
%token	SUBSET_OR_EQUAL
%token	SUPERSET_OR_EQUAL
%token	SET_CARDINALITY
%token	SET_EMPTY
%token	SET_HAS
%token	SET_SINGLETON
%token	SET_POWERSET
%token	SET_RETRIEVE
%token	SET_REMOVE
%token	SET_ADD
%token	FREADSET
%token	FWRITESET
%token	ENTERSET
%token	FOR
%token	WHILE
%token	IF
%token	ELSE
%token	PROGRAM
%token	MAIN
%token	RETURN
%token	IDENTIFIER
%token	SET
%token NEWLINE

%start program
%right ASSIGNMENT_OPERATOR

%%

//Start Rule

//Program
program: main
 
main:
	MAIN LP RP LCB statement_list RCB

statement_list: statement | statement_list statement


statement: assignment END | set_expression END | function_call END
		 | loop_statement | if_statement | comment_statement | simple_declaration
 | print_statement END | return_statement | function_definition 

//COMMENT
comment_statement: COMMENT


//COMPARATOR
comparator: SMALLER_THAN
| SMALLER_THAN_OR_EQUAL
| GREATER_THAN 		 
| GREATER_THAN_OR_EQUAL

//SET OPERATIONS
set_relation_operator: SUBSET
| SUBSET_OR_EQUAL 
| SUPERSET 
| SUPERSET_OR_EQUAL

set_operation_symbol: SET_INTERSECTION
| SET_UNION 
| SET_DIFFERENCE 
| SET_CARTESIAN
| SET_COMPLEMENT

//EXPRESSIONS
set_primaries: SET_ELEMENT | INT | BOOLEAN | IDENTIFIER | STRING | FLOAT

set_member_list: set_primaries
| set_member_list COMMA set_primaries | 

set_assignment: SET ASSIGNMENT_OPERATOR LCB set_member_list RCB
		| SET ASSIGNMENT_OPERATOR set_operator_expression

set_boolean_expression: SET set_relation_operator SET
			| set_has_expression
			| set_singleton_check_expression
			| set_empty_check_expression 
			| set_cardinality_expression comparator INT
			| set_cardinality_expression IS_EQUAL INT
			| set_cardinality_expression NOT_EQUAL INT

boolean_expression: BOOLEAN | set_boolean_expression | INT comparator INT
			| INT IS_EQUAL INT | INT NOT_EQUAL INT
			| INT comparator IDENTIFIER 	
			| IDENTIFIER comparator IDENTIFIER 
			| IDENTIFIER comparator INT
			| IDENTIFIER OR IDENTIFIER | IDENTIFIER AND IDENTIFIER
			| IDENTIFIER IS_EQUAL INT | IDENTIFIER NOT_EQUAL INT
			| INT IS_EQUAL IDENTIFIER | INT NOT_EQUAL IDENTIFIER
			| IDENTIFIER IS_EQUAL IDENTIFIER | IDENTIFIER NOT_EQUAL IDENTIFIER
			| IDENTIFIER IS_EQUAL NONE | IDENTIFIER NOT_EQUAL NONE
			| BOOLEAN IS_EQUAL BOOLEAN | BOOLEAN NOT_EQUAL BOOLEAN
			| function_call

boolean_list: boolean_expression | boolean_list AND boolean_expression | boolean_list OR boolean_expression

assignment: IDENTIFIER ASSIGNMENT_OPERATOR assignment_arg 

assignment_arg: boolean_list | INT 
 | set_cardinality_expression | FLOAT | STRING | NONE

set_create_expression: CREATE_SET LP SET RP

set_delete_expression: DELETE_SET LP SET RP 

set_operator_expression: SET set_operation_symbol SET 
			     | SET_POWERSET LP SET RP | set_operator_expression set_operation_symbol SET

set_retrieve_operation: SET_RETRIEVE LP SET COMMA INT RP
			| SET_RETRIEVE LP SET RP
	
set_cardinality_expression: SET_CARDINALITY LP SET RP

set_empty_check_expression: SET_EMPTY LP SET RP

set_has_expression: SET_HAS LP SET COMMA set_primaries RP

set_singleton_check_expression: SET_SINGLETON LP SET RP

set_remove_expression: SET_REMOVE LP SET COMMA set_primaries RP

set_add_expression: SET_ADD LP SET COMMA set_primaries RP

set_expression: set_create_expression | set_delete_expression 
                               | set_operator_expression | set_assignment | set_boolean_expression
| set_cardinality_expression | set_remove_expression
| set_add_expression | set_keyboard_input | set_retrieve_operation
| set_console_output | set_file_input | set_file_output 

//FUNCTION CALLS

break_statement: STOP END

continue_statement: CONTINUE END 

return_statement: RETURN arg END | RETURN END 

arg: SET | SET_ELEMENT | INT | boolean_list | FLOAT | STRING

arg_list : arg | arg_list COMMA arg

simple_declaration : IDENTIFIER END | SET END | SET_ELEMENT END

print_statement : PRINT LP IDENTIFIER RP
 | PRINT LP STRING RP 

function_definition : FUNCTION_DEFINE function_identifier LCB statement_list RCB

function_identifier: IDENTIFIER LP arg_list RP  | IDENTIFIER LP RP

function_call: IDENTIFIER FUNCTION_OPERATOR function_identifier
		| SET FUNCTION_OPERATOR function_identifier
		| function_identifier

//LOOPS AND CONDITIONALS
basic_for_loop: FOR LP assignment END boolean_list END assignment END RP LCB block RCB

set_for_loop: FOR LP IDENTIFIER COLON  SET RP LCB block RCB

for_loop: basic_for_loop | set_for_loop

while_loop: WHILE LP boolean_list RP LCB block RCB

loop_statement: for_loop | while_loop

if_statement: IF LP boolean_list RP LCB block RCB else_statement
		| IF LP boolean_list RP LCB block RCB

else_statement: ELSE LCB block RCB


block: continue_statement | break_statement | statement_list 

//INPUT OUTPUT
set_keyboard_input: ENTERSET LP SET RP

set_console_output: PRINTSET LP SET RP

set_file_input: FREADSET LP SET COMMA IDENTIFIER RP

set_file_output: FWRITESET LP SET COMMA IDENTIFIER RP

%%
#include "lex.yy.c"
int lineno= 1;
int yyerror(char* s){
  fprintf(stderr, "%s on line %d\n",s, lineno);
  return 1;
}

int main(void){
 yyparse();
if(yynerrs < 1){
		printf("Input program is valid\n");
	}
 return 0;
}

