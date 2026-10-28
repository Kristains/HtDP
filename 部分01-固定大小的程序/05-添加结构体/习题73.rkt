#lang racket

(require 2htdp/universe)
(require 2htdp/image)

; Posn Number -> Posn
; 更新 p 的 x 坐标
(check-expect (posn-up-x (make-posn 10 0) 13) (make-posn 13 0))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))
