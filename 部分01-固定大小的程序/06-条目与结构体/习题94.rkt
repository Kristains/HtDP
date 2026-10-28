#lang racket

(require 2htdp/image)

;; Definition

(define SCENE-WIDTH 400)
(define SCENE-HEIGHT 300)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define UFO-WIDTH 40)
(define UFO-HEIGHT 20)
(define UFO (overlay/align "center" "bottom"
             (rectangle (/ UFO-WIDTH 2) (/ UFO-HEIGHT 4) "solid" "red")
             (circle (/ UFO-HEIGHT 4) "solid" "green")))
(define UFO-X-START (/ SCENE-WIDTH 2))
(define UFO-Y-START (/ UFO-HEIGHT 2))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "blue"))
(define TANK-X-START (/ SCENE-WIDTH 2))
(define TANK-Y (- SCENE-HEIGHT (/ TANK-HEIGHT 2)))

;; Application

(place-image UFO
             UFO-X-START UFO-Y-START
             (place-image TANK
                          TANK-X-START TANK-Y
                          SCENE))
