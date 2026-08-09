#lang racket 
(requirt 2htdp/image)
;; P26 [习题5]
(define (leaves size)
  (triangle size "solid" "green")
  )

(define (truck size)
  (rectangle (/ size 5) (/ size 3) "solid" "brown"))

(define (draw-tree size)
  (above (leaves size) (truck size))
  )

(draw-tree 100)


(define (left-tri size) (triangle/sss (* 3 size) (* 5 size) (* 4 size) "solid" "white"))
(define (mid-rect size) (rectangle (* 7 size)  (* 3 size) "solid" "brown"))
(define (right-tri size) (triangle/sss (* 5 size) (* 3 size) (* 4 size) "solid" "white"))

(define (boat-body size) (beside/align "bottom" (left-tri size) (mid-rect size) (right-tri size)))

(define (flagpole size) (rectangle (/ size 5) (* 7 size) "solid" "brown"))
(define (flag size) (triangle/sss (* 5 size) (* 3 size) (* 4 size) "solid" "red"))

(define (boat-flag size) (beside/align "top" (flagpole size) (flag size)))

(define (draw-boat size) (overlay/xy (boat-body size) (* 7.5 size) (* -7 size) (boat-flag size)))

(draw-boat 100)
