#lang racket

(require parser-tools/yacc
         "lexer.rkt"
         "syntax.rkt")

(define spcf-parser
  (parser
   (start statements)
   (end EOF)
   (tokens value-tokens var-tokens syntax-tokens)
   (src-pos)
   (error
    (lambda (a b c d e)
      (begin
        (printf "a = ~a\nb = ~a\nc = ~a\nd = ~a\ne = ~a\n"
                a b c d e) (void))))
  
   (grammar
    (statements [() '()]
                [(statement statements) (cons $1 $2)])
  
    (statement [(QTEXEC COLON expr SEMI) (numero-execucoes $3)]
               [(GABARITO COLON expr SEMI) (gabarito $3)]
               [(EXERCICIOS COLON expr SEMI) (exercicios-alunos $3)])
    
    (expr  [(NUMBER) (value $1)]
           [(STRING) (value $1)]))))

(define (parse ip)
  (spcf-parser (lambda () (next-token ip))))

(provide parse)

