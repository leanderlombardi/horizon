grammar horizon;

prog: line* EOF;

line: functionCall | assignment | include | using | functionDeclaration;

functionCall: ID '(' (VAR (',' VAR)*?)? ')' ';';
assignment: 'var' ID (':' TYPE)? '=' VAR ';';
block: '{' line* '}';
include: COMMAND 'include' ('<' ID '>') | ('"' ID '"');
using: 'using' 'namespace' ID ';';
functionDeclaration: (VISUALTYPE | 'void' | 'voidf') '{' line* ('return' VAR)? '}';

VISUALTYPE: 'string' | 'int' | 'float' | 'bool';
VAR: TYPE;
TYPE: STRING | INT | FLOAT | BOOL;
ID: [a-zA-Z_][a-zA-Z0-9_]+;
STRING: '"' ID '"';
INT: [0-9]+;
FLOAT: [0-9]+ '.' [0-9]+;
BOOL: 'true' | 'false';
NULL: 'NULL';
WS: [ \t\r\n] -> skip;
COMMAND: '#';
