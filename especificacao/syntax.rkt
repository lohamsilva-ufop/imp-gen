#lang racket

;; expression syntax

(struct numero-execucoes
  (quantidade)
  #:transparent)

(struct gabarito
  (path)
  #:transparent)

(struct exercicios-alunos
  (path)
  #:transparent)

(struct value
  (value)
  #:transparent)

(provide (all-defined-out))

