#lang racket
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

(provide (all-defined-out))
