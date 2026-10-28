#lang racket

(require 2htdp/image)

; Define
(define WIDTH 100)
(define HEIGHT 100)
(define SCENE (empty-scene WIDTH HEIGHT))

(define ROCKET (bitmap "./images/rocket.png"))
(define ROCKET-HEIGHT (image-height ROCKET))


;; 火箭停留在地面.
(place-image ROCKET (/ WIDTH 2) (- HEIGHT (/ ROCKET-HEIGHT 2)) SCENE)

;; 火箭停留在图像的中心
(place-image ROCKET (/ WIDTH 2) (/ HEIGHT 2) SCENE)

;; 火箭放置在场景的最顶端位置
(place-image ROCKET (/ WIDTH 2) 0 SCENE)

;; 火箭放置在场景的最底端位置
(place-image ROCKET (/ WIDTH 2) HEIGHT SCENE)
