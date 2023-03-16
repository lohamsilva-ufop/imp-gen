#lang racket

(require "syntax.rkt" "table.rkt" "student-results.rkt"
         "../gerador/parser.rkt"
         "../gerador/interp.rkt")


(define (executa-gabarito path quantidade)
  (cond
    [(> quantidade 0)
      (begin
        (let*([port  (open-input-file path)]
               [text  (string-replace (read-string 1000 port) "#lang imp-gen/gerador/gen" "")])
               (begin
               (gen-interp (parse (open-input-string text)) trace-fread trace-fprint)
               (consolidate-last-entry)
                (new-iteration)
                (executa-gabarito path (- quantidade 1)))))]))

(define (executa-aluno path quantidade)
  (cond
    [(> quantidade 0)
      (begin
        (let*([port  (open-input-file path)]
               [text  (string-replace (read-string 1000 port) "#lang imp-gen/gerador/gen" "")])
               (begin
               (gen-interp (parse (open-input-string text)) replay-fread student-trace-fprint)
               (new-result-instance)
               (consolidate-result)
               (next-line)
               (executa-aluno path (- quantidade 1)))))]))
  

;função que percorre a pasta com os arquivos dos alunos.
(define (percorre-path lista path quantidade)
  (cond
    [(empty? (rest lista)) (executa-gabarito (string-append path "/" (~a(first lista))) quantidade)]
    [else 
      (executa-gabarito (string-append path "/" (~a(first lista))) quantidade)
      (percorre-path (rest lista) path quantidade)]))

(define (eval-expr env e)
  (match e
    [(value val) (cons env (value val))]))

; eval-stmt env cnf table -> table
(define (eval-stmt env cfg)
  (match cfg
   [(config numero-execucoes gabarito dir-aluno-exercicios)
    (begin
      ;passar função de read e write para gabarito/aluno
      (executa-gabarito (value-value dir-aluno-exercicios) (value-value numero-execucoes))
      (drop-entry)
      (start-replay-mode)
      (executa-aluno (value-value gabarito) (value-value numero-execucoes))
      (drop-entry-result)
      (consolidate-lines)
      (start-replay-mode)
      (start-table-result)
      ;(display result-table)
      (correct-exercise))]))

;função principal do interpretador
;imp-spcf-interp: config table -> table
(define (imp-spcf-interp cfg)
  (eval-stmt (make-immutable-hash) cfg))

(provide imp-spcf-interp eval-expr)





; eval-stmt env cnf table -> table
;(define (eval-stmt env cfg)
;  (match cfg
;   [(config numero-execucoes gabarito exercicio-aluno)
    ;o nó CONFIG possui: o numero de execucoes, o caminho do arquivo de gabarito e a pasta com os arquivos dos alunos
    ;primeiro executa o arquivo de gabarito do professor com a função executa-arquivo
;    (let* ([table1 (executa-arquivo (value-value gabarito) (value-value numero-execucoes))])
    ;depois executa os arquivo da pasta dos alunos com a função percorre-path
     ;   (percorre-path (directory-list (value-value exercicio-aluno)) (value-value exercicio-aluno) (value-value numero-execucoes)))]))


