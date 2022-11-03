#lang racket

;; expression syntax

(struct type
  (name)
  #:transparent)

(struct input
  (type id size)
  #:transparent)

(struct value
  (value)
  #:transparent)

(struct xinput
  (var)
  #:transparent)

(struct var
  (id)
  #:transparent)

(struct add
  (left right)
  #:transparent)

(struct minus
  (left right)
  #:transparent)

(struct mult
  (left right)
  #:transparent)

(struct divv
  (left right)
  #:transparent)

(struct eeq
  (left right)
  #:transparent)

(struct lt
  (left right)
  #:transparent)

(struct eand
  (left right)
  #:transparent)

(struct enot
  (arg)
  #:transparent)

(struct to
  (left right)
  #:transparent)

; statement syntax

(struct assign
  (var expr)
  #:transparent)

(struct inicializador
  (var expr)
  #:transparent)

(struct sprint
  (expr)
  #:transparent)

(struct eif
  (econd then-block else-block)
  #:transparent)

(struct ewhile
  (econd block)
  #:transparent)

(struct efor
  (init stop block)
  #:transparent)

(provide (all-defined-out))

