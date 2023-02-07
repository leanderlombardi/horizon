grammar horizon;

// BASIC

program
:
	line* EOF
;

line
:
	command
	| assignment
	| functionCall
	| functionBlock
	| functionalFunctionBlock
	| ifBlock
	| whileBlock
	| classBlock
	| returnStatement
	| expression
	| reassignment
;

// COMMANDS

includeCommand
:
	'include'
	(
		'<' LIBRARY '>'
	)
	|
	(
		'"' LIBRARY '"'
	)
;

// NORMAL RULES

command
:
	COMMAND
	(
		includeCommand
	)
;

assignment
:
	'var' ID
	(
		'[' INT? ']'
	)?
	(
		':' VTYPE
	)? '=' VALUE stropt?
	| functionalFunctionCall
;

reassignment
:
	(
		ID ':' VTYPE
	)
	|
	(
		ID ':' VTYPE '=' VALUE stropt?
	)
	|
	(
		ID '=' VALUE stropt?
	)
;

stropt
:
	'.'
	(
		'replace' '(' VALUE VALUE ')'
	)
	|
	(
		'lower' '(' ')'
	)
	|
	(
		'upper' '(' ')'
	)
;

functionCall
:
	(
		ID '('
		(
			VALUE
			(
				',' VALUE
			)*?
		)? ')'
	)
	| 'println' '(' VALUE ')'
	| 'print' '(' VALUE ')'
;

functionalFunctionCall
:
	'read' '(' STRING? ')'
	| 'readkey' '(' STRING? ')'
;

functionBlock
:
	'void' ID '('
	(
		ID
		(
			'[' INT? ']'
		)?
		(
			':' VTYPE
		)?
		(
			',' ID
			(
				'[' INT? ']'
			)?
			(
				':' VTYPE
			)?
		)*?
	)? ')' block
;

functionalFunctionBlock
:
	'voidf' ID '('
	(
		ID
		(
			'[' INT? ']'
		)?
		(
			':' VTYPE
		)?
		(
			',' ID
			(
				'[' INT? ']'
			)?
			(
				':' VTYPE
			)?
		)*?
	)? ')' blockf
;

ifBlock
:
	'if' '(' expression
	(
		'&&' expression
	)*? ')' block
	(
		elseIfBlock
	)?
;

elseIfBlock
:
	'else' ifBlock?
	| block
;

whileBlock
:
	'while' '(' expression
	(
		'&&' expression
	)*? ')' block
;

classBlock
:
	'class' ID block
;

returnStatement
:
	'return' VALUE
;

expression
:
	VALUE BOOLOP VALUE # boolexpr
	|
	(
		INT
		| FLOAT
	) MULOP
	(
		INT
		| FLOAT
	) # mulexpr
	|
	(
		INT
		| FLOAT
	) ADDOP
	(
		INT
		| FLOAT
	) # addexpr
	| TYPE # constexpr
	| '(' expression ')' # parenexpr
	| ID # idexpr
;

// SOME RULES

block
:
	'{' line* '}'
;

blockf
:
	'{' line* returnStatement '}'
;

ADDOP
:
	'+'
	| '-'
;

BOOLOP
:
	'=='
	| '!='
	| '>'
	| '<'
	| '>='
	| '<='
;

MULOP
:
	'*'
	| '/'
;

COMMAND
:
	'#'
;

LIBRARY
:
	ID '.f'
;

TYPE
:
	STRING
	| INT
	| FLOAT
	| BOOL
;

VTYPE
:
	VSTRING
	| VINT
	| VFLOAT
	| VBOOL
;

VSTRING
:
	'string'
;

VINT
:
	'int'
;

VFLOAT
:
	'float'
;

VBOOL
:
	'bool'
;

INT
:
	[0-9]+
;

FLOAT
:
	[0-9]+ '.' [0-9]+
;

STRING
:
	'"'
	(
		ID
		|
		(
			'$' '{' ID '}'
		)*?
	)*? '"'
;

BOOL
:
	'true'
	| 'false'
;

VALUE
:
	INT
	| FLOAT
	| STRING
	| BOOL
;

ID
:
	[a-z]+
;

WS
:
	[ \t\r\n]+ -> skip
;
