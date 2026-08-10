#lang racket

(define sunny #true)
(define friday #false)

(define (whether-go-market sunny friday) (or sunny friday))

(whether-go-market sunny friday)
