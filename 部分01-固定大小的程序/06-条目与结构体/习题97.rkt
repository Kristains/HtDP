#lang racket

(require 2htdp/image)

;; Definition

; (make-posn x y) 表示 UFO 的位置

(define-struct tank [loc vel])
; (make-tank Number Number)
; 坦克的位置(loc, TANK-Y), 坦克移动的速度 vel 个像素

; (make-posn x y) 表示导弹(missile)的位置

; SIGS
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; (make-aim UFO Tank)
; (make-fired UFO Tank Missile)
; 表示空间入侵者游戏的完整状态

(define SCENE-WIDTH 120)
(define SCENE-HEIGHT 120)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 10)
(define UFO (overlay
             (circle (/ UFO-HEIGHT 2) "solid" "palegreen")
             (rectangle UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))
(define UFO-X-START (/ SCENE-WIDTH 2))
(define UFO-Y-START (/ UFO-HEIGHT 2))
(define UFO-Y-LANDED (- SCENE-HEIGHT (/ UFO-HEIGHT 2)))
(define UFO-Y-SPEED 1)

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "blue"))
(define TANK-X-START (/ SCENE-WIDTH 2))
(define TANK-Y (- SCENE-HEIGHT (/ TANK-HEIGHT 2)))
(define TANK-SPEED 3)

(define MISSILE (triangle 6 "solid" "black"))
(define MISSILE-WIDTH (image-width MISSILE))
(define MISSILE-HEIGHT (image-height MISSILE))
(define MISSILE-Y-START (+ TANK-Y (/ MISSILE-HEIGHT 2)))
(define MISSILE-SPEED 5)

;; TEST

(define TEST-TANK (make-tank TANK-X-START TANK-SPEED))

(define TEST-UFO (make-posn UFO-X-START UFO-Y-START))
(define TEST-UFO-LANDED (make-posn UFO-X-START UFO-Y-LANDED))

(define TEST-MISSILE (make-posn UFO-X-START MISSILE-Y-START))

(define TEST-AIM (make-aim
              (make-posn 10 20)
              (make-tank 28 -3)))

(define TEST-HIT (make-fired
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))

(define TEST-LANDED (make-fired
              (make-posn 10 UFO-Y-LANDED)
              (make-tank 58 -3)
              (make-posn 58 UFO-Y-LANDED)))

;; Function

; SIGS -> Image
; 将 UFO, TANK 以及可能出现的 MISSILE 添加到 SCENE 中
(check-expect (si-render TEST-AIM)
              (tank-render (aim-tank TEST-AIM)
                  (ufo-render (aim-ufo TEST-AIM) SCENE)))
(check-expect (si-render TEST-HIT)
              (tank-render (fired-tank TEST-HIT)
                  (ufo-render (fired-ufo TEST-HIT)
                              (missile-render (fired-missile TEST-HIT) SCENE)))) 
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) SCENE))]
    [(fired? s)
     (tank-render (fired-tank s)
                  (ufo-render (fired-ufo s)
                              (missile-render (fired-missile s) SCENE)))]))

; Tank Image -> Image
; 将 t 添加到给定图像 im 中
(check-expect (tank-render TEST-TANK SCENE)
              (place-image TANK (tank-loc TEST-TANK) TANK-Y SCENE))
(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))

; UFO Image -> Image
; 将 u 添加到给定图像 im 中
(check-expect (ufo-render TEST-UFO SCENE)
              (place-image UFO (posn-x TEST-UFO) (posn-y TEST-UFO) SCENE))
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; Missible Image -> Image
; 将 m 添加到给定图像 im 中
(check-expect (missile-render TEST-MISSILE SCENE)
              (place-image MISSILE (posn-x TEST-MISSILE) (posn-y TEST-MISSILE) SCENE))
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))
