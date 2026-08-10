#lang racket

(define (==> sunny friday)
  (if (or (not sunny) friday ) #true #false))

(define a #false)
(define b #true)
(==> a b)
