#lang racket

(require 2htdp/image)

;; 定义区
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 3))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define CAR-BODY
  (rectangle (* WHEEL-RADIUS 7) (* WHEEL-RADIUS 3) "solid" "red"))
(define CAR-TOP
  (rectangle (* WHEEL-RADIUS 3) (* WHEEL-RADIUS 1) "solid" "blue"))

(define TWO-WHEELS
  (overlay/offset WHEEL (* WHEEL-RADIUS 3) 0 WHEEL))
(define CAR
  (underlay/offset
   (above CAR-TOP CAR-BODY)
   0
   (* 2 WHEEL-RADIUS)
   TWO-WHEELS))

(define BACKGROUND-WIDTH (* (image-width CAR) 8))
(define BACKGROUND-HEIGHT (* (image-height CAR) 2))

(define BACKGROUND
  (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))

;; 交互区
(place-image CAR
             (image-width CAR)
             (- BACKGROUND-HEIGHT (/ (image-height CAR) 2))
             BACKGROUND)
