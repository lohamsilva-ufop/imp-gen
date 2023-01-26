#lang racket

(require "parser.rkt"
         "interp.rkt"
         "syntax.rkt"
         "especificacao/table.rkt")


(provide (rename-out [imp-read read]
                     [imp-read-syntax read-syntax]))


(define (imp-read in)
  (syntax->datum
   (imp-read-syntax #f in)))

(define (imp-read-syntax path port)
  (datum->syntax
   #f
   `(module imp-mod racket
      ,(finish (imp-gen-interp (parse port) wread wprint)))))
;trocar o wread e wprint por fprint e fread

(define (finish env)
  (display "Tabela Resultante: ")
   (display table)
  (displayln "Finished!"))