#lang racket

(require "syntax.rkt"
         "../gerador/parser.rkt"
         "../gerador/interp.rkt")

;a funcao executa arquivo recebe o caminho do arquivo e a quantidade de execuções
(define (executa-arquivo path quantidade)
  (cond
    [(> quantidade 0)
     
  (display "Arquivo: ")
  (displayln path)
  (display "Execução numero: ")
  (displayln quantidade)

;chama o parser que gera a arvore de sintaxe do programa do aluno/professor e chama o interpretador da linguagem  
   (let* ([port  (open-input-file path)]
          [text  (string-replace (read-string 100 port) "#lang imp-gen/gerador/gen" "")])
  (gen-interp (parse (open-input-string text))))
; chama a função recursivamente até que a quantidade de execuções seja igual a 0
  (executa-arquivo path (- quantidade 1))]))

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

; a funcao eval faz o casamento de padrao do nó
(define (eval-stmt env cfg)
  (match cfg
   [(config numero-execucoes gabarito exercicio-aluno)
    ;o nó CONFIG possui: o numero de execucoes, o caminho do arquivo de gabarito e a pasta com os arquivos dos alunos
    ;primeiro executa o arquivo de gabarito do professor com a função executa-arquivo
        (executa-arquivo (value-value gabarito) (value-value numero-execucoes))
    ;depois executa os arquivo da pasta dos alunos com a função percorre-path
        (percorre-path (directory-list (value-value exercicio-aluno)) (value-value exercicio-aluno) (value-value numero-execucoes))]))

;função principal do interpretador
(define (imp-spcf-interp cfg)
  (eval-stmt (make-immutable-hash) cfg))

(provide imp-spcf-interp eval-expr)