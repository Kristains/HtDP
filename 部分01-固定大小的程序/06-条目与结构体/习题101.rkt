#lang racket

(require 2htdp/image)

;; Definition

; SIGS.v2
(define-struct sigs [ufo tank missile])
; (make-fired UFO Tank MissileOrNot)
; 表示空间入侵者游戏的完整状态

; Posn 表示 ufo
; (make-posn x y) 表示 UFO 的位置

(define-struct tank [loc vel])
; (make-tank Number Number)
; 坦克的位置(loc, TANK-Y), 坦克移动的速度 vel 个像素

; MissileOrNot 的情况有
; -- #false
; -- Posn
; #false 意味着导弹还没有发射,
; (make-posn x y) 表示导弹(missile)的位置


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
(define MISSILE-OUT-SCENE (- (/ MISSILE-HEIGHT 2)))

(define INIT-SIGS
  (make-sigs
   (make-posn UFO-X-START UFO-Y-START)
   (make-tank TANK-X-START TANK-SPEED)
   #false))

;; TEST

(define TEST-TANK (make-tank TANK-X-START TANK-SPEED))

(define TEST-UFO (make-posn UFO-X-START UFO-Y-START))
(define TEST-UFO-LANDED (make-posn UFO-X-START UFO-Y-LANDED))

(define TEST-MISSILE (make-posn UFO-X-START MISSILE-Y-START))

(define TEST-AIM (make-sigs
              (make-posn 20 20)
              (make-tank 28 -3)
              #false))

(define TEST-FIRED (make-sigs
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 100 103)))

(define TEST-HIT (make-sigs
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))

(define TEST-LANDED (make-sigs
              (make-posn 10 UFO-Y-LANDED)
              (make-tank 58 -3)
              (make-posn 58 UFO-Y-LANDED)))

(define TEST-MISSILE-COMPLETELY-OUT-OF-SCENE (make-sigs
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 100 MISSILE-OUT-SCENE)))

(define SCENE-WITHOUT-MISSILE
  (place-image TANK 28 TANK-Y 
    (place-image UFO 20 20
      SCENE)))

;; Function

; SIGS.v2 -> Image
; 在 SCENE 上渲染给定的游戏状态
(check-expect (missile-render.v2 #false SCENE-WITHOUT-MISSILE) SCENE-WITHOUT-MISSILE)
(check-expect (missile-render.v2 (make-posn 32 (- HEIGHT TANK-HEIGHT 10)) SCENE-WITHOUT-MISSILE)
              (place-image MISSILE 
                           32 (- HEIGHT TANK-HEIGHT 10)
                           SCENE-WITHOUT-MISSILE))
