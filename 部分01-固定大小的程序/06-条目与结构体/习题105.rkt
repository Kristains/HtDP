;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题105) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; Definitions

; 一个坐标(Coordinate)有:
; – 负数
; 在 y 轴上,到上边(顶部)的距离
; – 正数
; 在 x 轴上,到左边的距离
; – Posn
; 一个笛卡尔点


(define coord-y1 -10)
(define coord-y2 -20)

(define coord-x1 10)
(define coord-x2 20)

(define coord-p1 (make-posn 10 -10))
(define coord-p2 (make-posn 20 -20))
