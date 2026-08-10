#lang racket

(define (distance-to-origin x y) (sqrt (+ (* x x) (* y y))))

(distance-to-origin 3 4)
