#lang racket

(require "syntax.rkt")

(define (executa-arquivo path)
  (load path))

(define (percorre-path lista path)
  (displayln (string-append path "/" (~a(first lista))))
  (cond
    [(empty? (rest lista)) (executa-arquivo (string-append path "/" (~a(first lista))))]
    [else 
      (executa-arquivo (string-append path "/" (~a(first lista))))
      (percorre-path (rest lista) path)]))

(define (eval-expr env e)
  (match e
    [(value val) (cons env (value val))]))


(define (eval-stmt env s)
  (match s
    [(numero-execucoes quantidade)
        (display "Numero de execuções: ")
        (display (value-value quantidade))
        (displayln "")]

    [(gabarito path)
        (executa-arquivo (value-value path))]

     [(exercicios-alunos path)
       (percorre-path (directory-list (value-value path)) (value-value path))]))


(define (eval-stmts env blk)
  (match blk
    ['() env]
    [(cons s blks) (let ([nenv (eval-stmt env s)])
                       (eval-stmts nenv blks))]))

(define (imp-spcf-interp prog)
  (eval-stmts (make-immutable-hash) prog))

(provide imp-spcf-interp eval-expr)