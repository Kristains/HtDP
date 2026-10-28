#lang racket
;; P23 [习题2]
(define prefix "hello")
(define suffix "world")

(define (append-two-word a b)
  (string-append a "_" b)
  )

(append-two-word prefix suffix)
