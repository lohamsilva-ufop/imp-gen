#lang racket
(require text-table)
(require "table.rkt")
(struct result-roll (line data) #:transparent)
(define result-table (result-roll 0 (list null)))

;funcao de escrita
(define (result-write value)
  (set! result-table (result-roll (result-roll-line result-table)
                           (cons (cons value (car (result-roll-data result-table)))
                                 (cdr (result-roll-data result-table))))))

(define (new-result-instance)
  (set! result-table (result-roll (+ 1 (result-roll-line result-table))
                           (cons null (result-roll-data result-table)))))

(define (consolidate-result)
  (match result-table
    [(result-roll line data) (set! result-table (result-roll line (cons (reverse (car data)) (cdr data))))]))

(define (consolidate-lines)
  (match result-table
    [(result-roll line data) (set! result-table (result-roll line (reverse data)))]))

(define (next-line-result)
  (set! result-table (result-roll (+ 1 (result-roll-line result-table))(result-roll-data result-table))))

(define (start-table-result)
  (set! result-table (result-roll 0 (result-roll-data result-table))))

(define (can-advance-result?)
  (let*
        ([line (result-roll-line result-table)])
   (<= line (- (length (result-roll-data result-table)) 1))))

(define (check-message)
  (if (equal? (replay-write-list) (show-data-result))
     
      
      (begin

       ; (print-table
       ;`((Entrada/Saída_Gabarito Saída_Aluno Correção)
       ; (,(display table) ,(display (show-data-result)) "O exercicio está correto")))
        
        (display "Instância de entrada/saída do gabarito: ")
        (display (replay-reader-list))
        (display "/")
        (displayln (replay-write-list))
        (display "Saída do aluno: ")
        (displayln (show-data-result))
        (displayln "O exercicio está correto!")
        (displayln ""))

      (begin

       ; (print-table
       ;`((Entrada/Saída_Gabarito Saída_Aluno Correção)
       ; (,(display table) ,(display (show-data-result)) "O exercicio está correto")))
        
       (display "Instância de entrada/saída do gabarito: ")
        (display (replay-reader-list))
        (display "/")
        (displayln (replay-write-list))
        (display "Saída do aluno: ")
        (displayln (show-data-result))
        (displayln "O exercicio está incorreto!")
        (displayln ""))))

(define (correct-exercise)
  (cond
    [(can-advance-result?)(begin
                             (check-message)
                             (next-line-result)
                             (next-line)
                             (next-col-write)
                             (correct-exercise))]))

(define (show-data-result)
    (let*
        ([line (result-roll-line result-table)]
         [data (list-ref (result-roll-data result-table) line)])data))

(define (drop-entry-result)
   (match result-table
    [(result-roll l xs) (set! result-table (result-roll l (cdr xs)))]))

(define (drop-student-result)
   (match result-table
    [(result-roll l xs) (set! result-table (result-roll 0 (list null)))]))

(provide (all-defined-out))
