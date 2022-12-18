#lang racket

;; expression syntax

(struct config
  (numero-execucoes gabarito exercicio-aluno)
  #:transparent)

(struct value
  (value)
  #:transparent)

(provide (all-defined-out))

