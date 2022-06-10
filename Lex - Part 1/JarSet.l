%option main
digit 			[0-9]
positive_digit		[1-9]
sign			[+-]
assignment_operator	=
number			{digit}*
int 			{sign}?{number}
at 			@
left_parantheses	"("
right_parantheses	")"
left_curly_bracket	"{"
right_curly_bracket 	"}"
comma 			","
comment_symbol		\/\/
lowercase_letter	[a-z]
uppercase_letter	[A-Z]
non_digit_character	{letter}|@
character		{digit}|{non_digit_character}
letter 			{lowercase_letter}|{uppercase_letter}
identifier		{letter}|{character}*
boolean			"true"|"false"	
null			"NONE"
set_identifier		"#"
set_element		\'{identifier}\'|\'{int}\'
function_operator 	"->"
end 			";"	
and			"&"
or			"|"
is_equal		"=="
not_equal		"!="
smaller_than		"<"
greater_than		">"
smaller_than_or_equal	"<="
greater_than_or_equal	">="
set_intersection	"&=&"
set_union		"+=+"
set_difference		"-=-"
set_complement		"!=!"
set_cartesian		"X=X"
create_set_keyword	"createSet"
delete_set_keyword	"deleteSet"
subset			"<<"
superset		">>"
subset_or_equal		"<<=="
superset_or_equal	">>=="
set_cardinality_keyword	"getSetSize"
set_empty_keyword	"isEmpty"
set_has_keyword		"setHas"
set_singleton_keyword	"isSingleton"
set_powerset_keyword	"getPowerset"
set_retrieve_keyword	"retrieve"
set_remove_keyword	"remove"
set_add_keyword		"add"
printSet		"printSet"
enterSet		"enterSet"
fReadSet		"fReadSet"
fWriteSet		"fWriteSet"
for			"for"
while			"while"
if			"if"
else			"else"
program			"program"
main			"main"
print			"print"
return			"return"
define 			"define"
stop			"stop"
continue		"continue"
printf			"printf"
%%
{print}			printf("PRINT ");
{printf} 		printf("PRINTF ");
{printSet}		printf("PRINTSET ");
{continue}		printf("CONTINUE ");
{stop}			printf("STOP ");
{define}		printf("FUNCTION_DEFINE ");
{function_operator} 	printf("FUNCTION_OPERATOR ");
{set_identifier}	printf("SET_IDENTIFIER ");
{set_element}		printf("SET_ELEMENT ");
{int}			printf("INT ");
{at}			printf("AT ");
{assignment_operator}	printf("ASSIGNMENT_OPERATOR ");
{left_parantheses}	printf("LP ");
{right_parantheses}	printf("RP ");
{left_curly_bracket}	printf("LCB ");
{right_curly_bracket}	printf("RCB ");
{comma}			printf("COMMA ");
{comment_symbol}	printf("COMMENT_SYMBOL ");
{boolean}		printf("BOOLEAN ");
{null}			printf("NONE ");
{end}			printf("END ");
{and}			printf("AND ");
{or}			printf("OR ");
{is_equal}		printf("IS_EQUAL ");
{not_equal}		printf("NOT_EQUAL ");
{smaller_than}		printf("SMALLER_THAN ");
{greater_than}		printf("GREATER_THAN ");
{smaller_than_or_equal}	printf("SMALLER_THAN_OR_EQUAL ");
{greater_than_or_equal}	printf("GREATER_THAN_OR_EQUAL ");
{set_intersection}	printf("SET_INTERSECTION ");
{set_union}		printf("SET_UNION ");
{set_difference}	printf("SET_DIFFERENCE ");
{set_complement}	printf("SET_COMPLEMENT ");
{set_cartesian}		printf("SET_CARTESIAN ");
{create_set_keyword}	printf("CREATE_SET ");
{delete_set_keyword}	printf("DELETE_SET ");
{subset}		printf("SUBSET ");
{superset}		printf("SUPERSET ");
{subset_or_equal}	printf("SUBSET_OR_EQUAL ");
{superset_or_equal}	printf("SUPERSET_OR_EQUAL ");
{set_cardinality_keyword} printf("SET_CARDINALITY ");
{set_empty_keyword}	printf("SET_EMPTY ");
{set_has_keyword}	printf("SET_HAS ");
{set_singleton_keyword}	printf("SET_SINGLETON ");
{set_powerset_keyword}	printf("SET_POWERSET ");
{set_retrieve_keyword}	printf("SET_RETRIEVE ");
{set_remove_keyword}	printf("SET_REMOVE ");
{set_add_keyword}	printf("SET_ADD_EXPRESSION ");
{fReadSet}		printf("FREADSET ");
{fWriteSet}		printf("FWRITESET ");
{enterSet}		printf("ENTERSET ");
{for}			printf("FOR ");
{while}			printf("WHILE ");
{if}			printf("IF ");
{else}			printf("ELSE ");
{program}		printf("PROGRAM ");
{main}			printf("MAIN ");
{return}		printf("RETURN ");
{identifier}		printf("IDENTIFIER ");
{set_identifier}{identifier} printf("SET_TYPE ");
%%