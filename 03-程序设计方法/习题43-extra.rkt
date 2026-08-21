#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (render 50) (place-image CAR (car-x-position 50) (car-y-position 50) BACKGROUND))
(check-expect (render 200) (place-image CAR (car-x-position 200) (car-y-position 200) BACKGROUND))

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

(define CAR-START-X (- 0 (/ CAR-WIDTH 2)))
(define CAR-STOP-X (+ BACKGROUND-WIDTH (/ CAR-WIDTH 2)))
(define SINE-AMPLITUDE (/ (- BACKGROUND-HEIGHT CAR-HEIGHT) 2))
(define SINE-FREQUENCY 2)
; AnimationState is Number
; 自动画开始后经过的滴答数(as)

; Number -> Number
; 动画开始后经过的滴答数的汽车的 x 轴位置
(define (car-x-position ticks)
  (+ (* ticks VELOCITY) CAR-START-X))

; Number -> Number
; 动画开始后经过的滴答数的汽车的 y 轴位置
(define (car-y-position ticks)
  (+
   (* SINE-AMPLITUDE -1
      (sin
        (* (car-x-position ticks) 2 pi (/ SINE-FREQUENCY BACKGROUND-WIDTH))))
   SINE-AMPLITUDE (/ CAR-HEIGHT 2)))

; WorldState -> Image
; 获取当前世界状态的图像
(define (render as)
  (place-image CAR (car-x-position as) (car-y-position as) BACKGROUND))

; WorldState -> WorldState
; 时钟每滴答一下，big-bang 从(clock-tick-handler ws)
; 获取世界的下一个状态
; 时钟每滴答 1 次，滴答数加 1
(define (clock-tick-handler as)
  (+ as 1))

; WorldState String -> WorldState
; 对于每一次按键,big-bang 从(keystroke-handler ws ke)
; 获取世界的下一个状态，ke 表示按键
(define (keystroke-handler ws ke)...)

; WorldState Number Number String -> WorldState
; 对于每一次按键,big-bang 从(mouse-event-handler ws x y me)
; 获取世界的下一个状态,其中 x 和 y 是事件的坐标，me 表示事件的描述
(define (mouse-event-handler ws x y me)...)

; WorldState -> Boolean
; 在每一个事件发生之后，big-bang 对(end? ws)求值
(define (end? as)
  (> (car-x-position as) CAR-STOP-X))

; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main as)
  (big-bang as
    [to-draw render]
    [on-tick clock-tick-handler]
    [stop-when end?]))
