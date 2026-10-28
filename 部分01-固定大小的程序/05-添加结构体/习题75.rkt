#lang racket

(define-struct ufo [loc vel])
; UFO 是结构体
;     (make-ufo Posn Vel)
; 解释: (make-ufo p v) 位于位置 p, 以速度 v 运动

(define-struct vel [deltax deltay])
; VEL 是结构体
;     (make-vel deltax deltay)
; 解释: (make-ufo dx dy) 在 x 轴以速度 dx 运动，在 y 轴以速度 dy 运动

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; 确定一个时钟滴答之后 u 会移动到哪里
; 保持速度不变
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))

(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

; Posn Vel -> Posn
; 将 v 加到 p 上
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))
