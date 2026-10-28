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
(define MISSILE-OUT-SCENE (- (/ MISSILE-HEIGHT 2)))

;; TEST

(define TEST-TANK (make-tank TANK-X-START TANK-SPEED))

(define TEST-UFO (make-posn UFO-X-START UFO-Y-START))
(define TEST-UFO-LANDED (make-posn UFO-X-START UFO-Y-LANDED))

(define TEST-MISSILE (make-posn UFO-X-START MISSILE-Y-START))

(define TEST-AIM (make-aim
              (make-posn 20 20)
              (make-tank 28 -3)))

(define TEST-FIRED (make-fired
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 100 103)))

(define TEST-HIT (make-fired
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))

(define TEST-LANDED (make-fired
              (make-posn 10 UFO-Y-LANDED)
              (make-tank 58 -3)
              (make-posn 58 UFO-Y-LANDED)))

(define TEST-MISSILE-COMPLETELY-OUT-OF-SCENE (make-fired
              (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 100 MISSILE-OUT-SCENE)))

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

; SIGS -> Boolean
; 检查游戏是否停止(UFO 着陆或 Missible 击中 UFO)
(check-expect (si-game-over? TEST-AIM) #false)
(check-expect (si-game-over? TEST-LANDED) (ufo-landed? (fired-ufo TEST-LANDED)))
(check-expect (si-game-over? TEST-HIT) (missile-hit-ufo? (fired-ufo TEST-HIT) (fired-missile TEST-HIT)))
(define (si-game-over? s)
  (cond
    [(aim? s)
     (ufo-landed? (aim-ufo s))]
    [(fired? s)
     (or
      (ufo-landed? (fired-ufo s))
      (missile-hit-ufo? (fired-ufo s) (fired-missile s)))]
    ))

; Posn -> Boolean
; 检查 UFO 是否着陆
(check-expect (ufo-landed? TEST-UFO-LANDED) #true)
(check-expect (ufo-landed? TEST-UFO) #false)
(define (ufo-landed? u)
  (if (>= (posn-y u) UFO-Y-LANDED)
      #true
      #false))

; Posn Posn -> Boolean
; 检查 Missile 是否击中 UFO
(check-expect (missile-hit-ufo? (fired-ufo TEST-HIT) (fired-missile TEST-HIT)) (collision? (fired-ufo TEST-HIT) UFO-WIDTH UFO-HEIGHT
              (fired-missile TEST-HIT) MISSILE-WIDTH MISSILE-HEIGHT))
(check-expect (missile-hit-ufo? (fired-ufo TEST-LANDED) (fired-missile TEST-LANDED)) (collision? (fired-ufo TEST-LANDED) UFO-WIDTH UFO-HEIGHT
              (fired-missile TEST-LANDED) MISSILE-WIDTH MISSILE-HEIGHT))
(define (missile-hit-ufo? u m)
  (collision? u UFO-WIDTH UFO-HEIGHT
              m MISSILE-WIDTH MISSILE-HEIGHT))

; Posn Number Number Posn Number Number -> Boolean
; 判断两个以 p1、p2 为中心、宽高分别为 w1/h1、w2/h2 的矩形是否重叠
(check-expect (collision? (fired-ufo TEST-HIT) UFO-WIDTH UFO-HEIGHT
              (fired-missile TEST-HIT) MISSILE-WIDTH MISSILE-HEIGHT) #true)
(check-expect (collision? (fired-ufo TEST-LANDED) UFO-WIDTH UFO-HEIGHT
              (fired-missile TEST-LANDED) MISSILE-WIDTH MISSILE-HEIGHT) #false)
(define (collision? p1 w1 h1 p2 w2 h2)
  (and
   (<= (abs (- (posn-x p1) (posn-x p2)))
       (+ (/ w1 2) (/ w2 2)))
   (<= (abs (- (posn-y p1) (posn-y p2)))
       (+ (/ h1 2) (/ h2 2)))))

; SIGS -> Image
; 展现游戏结束画面
(check-expect (si-render-final TEST-LANDED) (si-render-final-text-layer TEST-LANDED "Game Over"))
(check-expect (si-render-final TEST-HIT) (si-render-final-text-layer TEST-HIT "YOU WON"))
(define (si-render-final s)
  (if (ufo-landed? (if (aim? s) (aim-ufo s) (fired-ufo s)))
      (si-render-final-text-layer s "Game Over")
      (si-render-final-text-layer s "YOU WON")))

; SIGS -> Image
; 展现游戏结束的文字层画面
(check-expect (si-render-final-text-layer TEST-LANDED "Game Over") (place-image (text "Game Over" 15 "orange")
               (/ SCENE-WIDTH 2)
               (/ SCENE-HEIGHT 5)
               (si-render TEST-LANDED)))
(check-expect (si-render-final-text-layer TEST-HIT "YOU WON") (place-image (text "YOU WON" 15 "orange")
               (/ SCENE-WIDTH 2)
               (/ SCENE-HEIGHT 5)
               (si-render TEST-HIT)))
(define (si-render-final-text-layer s t)
  (place-image (text t 15 "orange")
               (/ SCENE-WIDTH 2)
               (/ SCENE-HEIGHT 5)
               (si-render s)))

; si-move : SIGS -> SIGS
; 随时间移动游戏中的物体
(check-random (si-move TEST-AIM) (make-aim (make-posn (+ 20
                                                             (+ (random 21) -10))
                                                      21)
                                           (make-tank 25 -3)))
(check-random (si-move TEST-FIRED) (make-fired (make-posn (+ 20
                                                             (+ (random 21) -10))
                                                          101)
                                               (make-tank 103 3)
                                               (make-posn 100 98)))
(check-random (si-move TEST-MISSILE-COMPLETELY-OUT-OF-SCENE) (make-aim (make-posn (+ 20
                                                                                       (+ (random 21) -10))
                                                                                    101)
                                                                         (make-tank 103 3)))
(define (si-move s)
  (cond
    [(aim? s)
     (make-aim (si-move-ufo (aim-ufo s) (+ (random 21) -10))
               (si-move-tank (aim-tank s)))]
    [(fired? s)
     (cond
       [(missile-completely-out-of-scene? (fired-missile s))
        (make-aim (si-move-ufo (fired-ufo s) (+ (random 21) -10))
                  (si-move-tank (fired-tank s)))]
       [else
        (make-fired (si-move-ufo (fired-ufo s) (+ (random 21) -10))
                    (si-move-tank (fired-tank s))
                    (si-move-missile (fired-missile s)))])]))

; missile-completely-out-of-scene? : Missile -> Boolean
; 判断导弹是否完全飞出场景外
(check-expect (missile-completely-out-of-scene? (fired-missile TEST-MISSILE-COMPLETELY-OUT-OF-SCENE)) #true)
(check-expect (missile-completely-out-of-scene? (fired-missile TEST-FIRED)) #false)
(define (missile-completely-out-of-scene? m)
  (<= (posn-y m) MISSILE-OUT-SCENE))

; si-move-ufo : UFO Number -> UFO 
; 移动 UFO
(check-expect (si-move-ufo (make-posn 15 50) 5)
              (make-posn 20 (+ 50 UFO-Y-SPEED)))
(check-expect (si-move-ufo (make-posn 15 50) -5)
              (make-posn 10 (+ 50 UFO-Y-SPEED)))
(check-expect (si-move-ufo (make-posn 10 50) -5)
              (make-posn 10 (+ 50 UFO-Y-SPEED)))
(define (si-move-ufo u delta)
      (make-posn
       (if (safe-ufo-x? (+ (posn-x u) delta))
           (+ (posn-x u) delta)
           (posn-x u))
       (+ (posn-y u) UFO-Y-SPEED)))

; safe-ufo-x? : Number -> Boolean
; 判断 UFO 的横坐标是否在边界内
(check-expect (safe-ufo-x? 5) #false)
(check-expect (safe-ufo-x? 50) #true)
(define (safe-ufo-x? u-x)
  (cond
    [(and (>= u-x (/ UFO-WIDTH 2))
          (<= u-x (- SCENE-WIDTH (/ UFO-WIDTH 2))))
      #true]
    [else #false]))

; si-move-tank : TANK -> TANK 
; 移动 TANK
(check-expect (si-move-tank (make-tank 10 5))
              (make-tank 15 5))
(check-expect (si-move-tank (make-tank 10 -5))
              (make-tank 10 -5))
(define (si-move-tank t)
  (make-tank
   (if (safe-tank-loc? (+ (tank-loc t) (tank-vel t)))
                 (+ (tank-loc t)
                    (tank-vel t))
                 (tank-loc t))
   (tank-vel t)))

; safe-tank-loc? : Number -> Boolean
; 判断 Tank 的横坐标是否在边界内
(check-expect (safe-tank-loc? 5) #false)
(check-expect (safe-tank-loc? 50) #true)
(define (safe-tank-loc? t-l)
  (cond
    [(and (>= t-l (/ TANK-WIDTH 2))
          (<= t-l (- SCENE-WIDTH (/ TANK-WIDTH 2))))
      #true]
    [else #false]))

; si-move-missile : MISSILE -> MISSILE 
; 移动 MISSILE
(check-expect (si-move-missile (make-posn 15 50))
              (make-posn 15 (- 50 MISSILE-SPEED)))
(define (si-move-missile m)
  (make-posn
   (posn-x m)
   (- (posn-y m) MISSILE-SPEED)))
