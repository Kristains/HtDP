#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (render 50) (place-image CAR (car-position 50) Y_CAR BACKGROUND))
(check-expect (render 200) (place-image CAR (car-position 200) Y_CAR BACKGROUND))

(check-expect (clock-tick-handler 20) (+ 20 1))
(check-expect (clock-tick-handler 78) (+ 78 1))

(check-expect (end? 0) #false)
(check-expect (end? (+ CAR-STOP-X 1)) #true)

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
(define CAR-WIDTH (image-width CAR))
(define CAR-HEIGHT (image-height CAR))

(define VELOCITY 3)

(define BACKGROUND-WIDTH (* CAR-WIDTH 8))
(define BACKGROUND-HEIGHT (* CAR-HEIGHT 2))
(define tree
  (underlay/xy (circle 10 "solid" "green")
              9 15
              (rectangle 2 20 "solid" "brown")))
(define BACKGROUND
  (place-image
   tree
   (/ BACKGROUND-WIDTH 7)
   (- BACKGROUND-HEIGHT (/ (image-height tree) 2))
   (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT)))

(define Y_CAR
  (- BACKGROUND-HEIGHT (/ (image-height CAR) 2)))
(define CAR-START-X (- 0 (/ CAR-WIDTH 2)))
(define CAR-STOP-X (+ BACKGROUND-WIDTH (/ CAR-WIDTH 2)))

; AnimationState is Number
; 自动画开始后经过的滴答数(as)

; Number -> Number
; 动画开始后经过的滴答数的汽车位置
(define (car-position ticks)
  (+ (* ticks VELOCITY) CAR-START-X))

; WorldState -> Image
; 获取当前世界状态的图像
(define (render as)
  (place-image CAR (car-position as) Y_CAR BACKGROUND))

; WorldState -> WorldState
; 时钟每滴答一下，big-bang 从(clock-tick-handler as)
; 获取世界的下一个状态
; 时钟每滴答 1 次，滴答数加 1
(define (clock-tick-handler as)
  (+ as 1))

; WorldState -> Boolean
; 在每一个事件发生之后，big-bang 对(end? as)求值
(define (end? as)
  (> (car-position as) CAR-STOP-X))

; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main as)
  (big-bang as
    [to-draw render]
    [on-tick clock-tick-handler]
    [stop-when end?]))
