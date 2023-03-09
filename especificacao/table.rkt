#lang racket
(struct entry (inputs outputs) #:transparent)

(struct roll (line col wcol data) #:transparent)

(define table (roll 0 0 0 (list (entry null null))))

(define (new-iteration)
  (set! table (roll (roll-line table)
                    (roll-col table)
                    (roll-wcol table)
                    (cons (entry null null) (roll-data table)))))
;AO ESCREVER, INCREMENTAR

(define (consolidate-last-entry)
  (match table
    [(roll l c w (cons (entry imp out) xs)) (set! table (roll l c w (cons (entry (reverse imp) (reverse out)) xs)))]))

(define (wread v)
  (match table
    [(roll l c w (cons (entry imp out) xs)) (set! table (roll l c w (cons (entry (cons v imp) out) xs)))]))

(define (wprint v)
   (match table
    [(roll l c w (cons (entry imp out) xs)) (set! table (roll l c w (cons (entry imp (cons v out)) xs)))]))

(define (start-replay-mode)
  (set! table (roll 0 0 0 (roll-data table))))

(define (start-col)
  (set! table (roll (roll-line table) 0 0 (roll-data table))))

(define (next-col-read)
  (set! table (roll (roll-line table) (+ 1 (roll-col table)) (roll-wcol table) (roll-data table))))

(define (next-col-write)
  (set! table (roll (roll-line table) (roll-col table) (+ 1 (roll-wcol table)) (roll-data table))))

(define (next-line)
  (set! table (roll (+ 1 (roll-line table)) 0 0 (roll-data table))))

(define (replay-read)
  (let*
      ([line (roll-line table)]
       [col (roll-col table)]
       [data-line (list-ref (roll-data table) line)])

   
      (cond [(can-replay-read?) (begin
                                  (next-col-read)
                                  (list-ref (entry-inputs data-line) col))]
            [else 'replay-read-failure])))

(define (replay-write)
  (let*
      ([line (roll-line table)]
       [col (roll-wcol table)]
       [data-line (list-ref (roll-data table) line)])

    (begin
      (list-ref (entry-outputs data-line) col))))


(define (can-replay-read?)
  (let*
      ([line (roll-line table)]
       [col (roll-col table)]
       [data-line (list-ref (roll-data table) line)])

   (<= col (- (length (entry-inputs data-line)) 1) )))

(define (can-advance-line?)
  (let*
      ([line (roll-line table)]
       [tb (roll-data table)])

   (<= line (- (length tb)) 1) ))

(define (can-replay-write?)
  (let*
      ([line (roll-line table)]
       [col (roll-wcol table)]
       [data-line (list-ref (roll-data table) line)])

   (<= col (- (length (entry-outputs data-line)) 1) )))

(define (drop-entry)
   (match table
    [(roll l c w xs) (set! table (roll l c w (cdr xs)))]))

(provide table
         new-iteration
         wread
         drop-entry
         wprint
         start-replay-mode
         next-col-read
         next-col-write
         next-line
         replay-read
         replay-write
         can-replay-read?
         can-replay-write?
         can-advance-line?
         consolidate-last-entry)

;compare-print
   ;contador de colunas separados r-col e f-col (após replay)
       ;campo de leitura para os prints -]> verificar o ponteiro da coluna.
       ;replay