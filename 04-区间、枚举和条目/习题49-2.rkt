#lang racket

(require 2htdp/image)

; Define
(define WIDTH 100)
(define HEIGHT 60)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "./images/rocket.png"))
(define ROCKET-CENTER-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define (create-rocket-scene.v5 h)
  (place-image ROCKET 50 (cond [(<= h ROCKET-CENTER-TOP) h]
                               [else ROCKET-CENTER-TOP]) MTSCN))

; Application
(create-rocket-scene.v5 20)

(create-rocket-scene.v5 60)
