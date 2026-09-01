#lang racket

; Define
(define y 100)
; (define y 210)

; Application
(- 200 (cond [(> y 200) 0] [else y]))
