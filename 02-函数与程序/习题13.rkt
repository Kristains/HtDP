#lang racket

(define (string-first s)
  (string (string-ref s 0)))

(string-first "hello")
