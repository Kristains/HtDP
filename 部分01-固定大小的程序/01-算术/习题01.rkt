#lang racket
;; P22 [习题1]
(define x 3)
(define y 4)

(define (distance-to-origin a b)
  (sqrt (+ (* a a) (* b b)))
  )

(distance-to-origin x y)
