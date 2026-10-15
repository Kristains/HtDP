;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题102) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
; 将 UFO, TANK 以及可能出现的 MISSILE 添加到 SCENE 中
(check-expect (si-render.v2 TEST-AIM)
              (place-image UFO 20 20
                           (place-image TANK 28 TANK-Y
                                        SCENE)))
(check-expect (si-render.v2 TEST-FIRED)
              (place-image UFO 20 100
                           (place-image TANK 100 TANK-Y
                                        (place-image MISSILE 100 103
                                                     SCENE))))
(define (si-render.v2 s)
  (tank-render
   (sigs-tank s)
   (ufo-render (sigs-ufo s)
               (missile-render.v2 (sigs-missile s)
                                  SCENE))))

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

; MissileOrNot -> Image
; 在 SCENE 上渲染给定的游戏状态
(check-expect (missile-render.v2 #false SCENE-WITHOUT-MISSILE) SCENE-WITHOUT-MISSILE)
(check-expect (missile-render.v2 (make-posn 32 (- SCENE-HEIGHT TANK-HEIGHT 10)) SCENE-WITHOUT-MISSILE)
              (place-image MISSILE 
                           32 (- SCENE-HEIGHT TANK-HEIGHT 10)
                           SCENE-WITHOUT-MISSILE))
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m)
     (place-image MISSILE (posn-x m) (posn-y m) s)]))
