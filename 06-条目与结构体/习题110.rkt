;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题110) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; 计算半径为 r 的圆盘的面积
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; 如果 v 是正数
; 计算半径为 v 的圆盘的面积
(define (checked-area-of-disk v)
  (cond
    [(and (number? v)
          (> v 0)) (area-of-disk v)]
    [else (error "area-of-disk: number expected")]))
