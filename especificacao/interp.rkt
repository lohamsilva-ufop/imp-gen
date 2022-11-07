#lang racket

(require "syntax.rkt")

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
        (display "Localização do gabarito do professor: ")
        (display (value-value path))
        (displayln "")]

     [(exercicios-alunos path)
        (display "Localização da pasta com os exercicios dos alunos: ")
        (display (value-value path))
        (displayln "")]))


(define (eval-stmts env blk)
  (match blk
    ['() env]
    [(cons s blks) (let ([nenv (eval-stmt env s)])
                       (eval-stmts nenv blks))]))

(define (imp-spcf-interp prog)
  (eval-stmts (make-immutable-hash) prog))

(provide imp-spcf-interp eval-expr)