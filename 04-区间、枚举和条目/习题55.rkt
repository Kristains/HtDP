#lang racket

(require 2htdp/image)

;; 定义区

(define HEIGHT 300)
(define WIDTH 100)
(define YDELTA 3)

(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))

(define CENTER (/ (image-height ROCKET) 2))

; LRCD -> Image
; 将状态呈现为停止或飞行中的火箭
(define (show x)
  (cond
    [(string? x)
     (draw-rocket (- HEIGHT CENTER))]
    [(<= -3 x -1)
     (plcae-image (text (number->string x) 20 "red")
              10 (* 3/4 WIDTH)
              (draw-rocket (- HEIGHT CENTER)))]
    [(>= x 0)
     (draw-rocket (- x CENTER))]))

(define (draw-rocket y)
  (place-image ROCKET 10 (- y CENTER) BACKG)
