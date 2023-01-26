#lang racket

(require "syntax.rkt" "table.rkt"
         "../gerador/parser.rkt"
         "../gerador/interp.rkt")


(define (executa-arquivo path quantidade)
  ;definir depois o caso base (else)
  (cond
    [(> quantidade 0)
      (begin
      ;  (display "Arquivo: ")
       ; (displayln path)
       ; (display "Execução numero: ")
       ; (displayln quantidade)

;chama o parser que gera a arvore de sintaxe do programa do aluno/professor e chama o interpretador da linguagem
      
        (let*([port  (open-input-file path)]
               [text  (string-replace (read-string 1000 port) "#lang imp-gen/gerador/gen" "")])
               (begin
               (gen-interp (parse (open-input-string text)) wread wprint)
                (executa-arquivo path (- quantidade 1)))))]))
  

;função que percorre a pasta com os arquivos dos alunos.
(define (percorre-path lista path quantidade)
  (cond
    [(empty? (rest lista)) (executa-arquivo (string-append path "/" (~a(first lista))) quantidade)]
    [else 
      (executa-arquivo (string-append path "/" (~a(first lista))) quantidade)
      (percorre-path (rest lista) path quantidade)]))

(define (eval-expr env e)
  (match e
    [(value val) (cons env (value val))]))

; eval-stmt env cnf table -> table
(define (eval-stmt env cfg)
  (match cfg
   [(config numero-execucoes gabarito)
    (executa-arquivo (value-value gabarito) (value-value numero-execucoes))]))

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

