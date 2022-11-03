#lang racket

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))


(define-tokens value-tokens (NUMBER))
(define-tokens var-tokens (IDENTIFIER))
(define-tokens gen-tokens (INPUT_COMMENT))
(define-empty-tokens syntax-tokens
  (EOF
   ADD
   SUBTRACT
   PRODUCT
   DIVISION
   LT
   EQ
   ASSIGN
   NOT
   AND
   SEMI
   COMMA
   LPAREN
   RPAREN
   IF
   THEN
   ELSE
   WHILE
   DO
   FOR
   TO
   BEGIN
   END
   INT
   FLOAT
   DOUBLE
   STRING
   PRINT
   INPUT))

(define next-token
  (lexer-src-pos
   [(eof) (token-EOF)]
   [(:+ #\newline whitespace)
    (return-without-pos (next-token input-port))]
   [#\+ (token-ADD)]
   [#\- (token-SUBTRACT)]
   [#\* (token-PRODUCT)]
   [#\/ (token-DIVISION)]
   [#\< (token-LT)]
   ["==" (token-EQ)]
   [":=" (token-ASSIGN)]
   ["!"  (token-NOT)]
   ["&&" (token-AND)]
   [";"  (token-SEMI)]
   [","  (token-COMMA)]
   ["("  (token-LPAREN)]
   [")"  (token-RPAREN)]
   ["if" (token-IF)]
   ["then" (token-THEN)]
   ["else" (token-ELSE)]
   ["while" (token-WHILE)]
   ["for" (token-FOR)]
   ["to" (token-TO)]
   ["do" (token-DO)]
   ["begin" (token-BEGIN)]
   ["end" (token-END)]
   ["int" (token-INT)]
   ["float" (token-FLOAT)]
   ["double" (token-DOUBLE)]
   ["string" (token-STRING)]
   ["print" (token-PRINT)]
   ["input" (token-INPUT)]
   [(:: "//@" (:*(complement (:: any-string #\newline any-string))) #\newline)  (token-INPUT_COMMENT lexeme)]
   [(:: "//" (:~ "@") (:*(complement (:: any-string #\newline any-string))) #\newline) (return-without-pos (next-token input-port))]
   [(:: "/*" (complement (:: any-string "*/" any-string)) "*/") (return-without-pos (next-token input-port))]
   [(:: alphabetic (:* (:+ alphabetic numeric)))
    (token-IDENTIFIER lexeme)]
   [(:: numeric (:* numeric))
    (token-NUMBER (string->number lexeme))]))

(provide next-token value-tokens var-tokens gen-tokens syntax-tokens)
