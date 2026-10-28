#lang racket

(define (cvolume side) (* side side side))

(define (csurface side)(* 6 (* side side)))

(cvolume 5)
(csurface 5)
