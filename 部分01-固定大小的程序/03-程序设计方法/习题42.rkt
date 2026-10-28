#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (render 50) (place-image CAR 50 Y_CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y_CAR BACKGROUND))

(check-expect (clock-tick-handler 20) (+ 20 VELOCITY))
(check-expect (clock-tick-handler 78) (+ 78 VELOCITY))

(check-expect (end? BACKGROUND-WIDTH) #false)
(check-expect (end? (* 2 BACKGROUND-WIDTH)) #true)

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

; WorldState: 代表世界状态的数据(ws)

; WorldState -> Image
; 需要时,big-bang 通过对(render ws)求值
; 获取当前世界状态的图像
(define (render ws)
  (place-image CAR ws Y_CAR BACKGROUND))

; WorldState -> WorldState
; 时钟每滴答一下，big-bang 从(clock-tick-handler ws)
; 获取世界的下一个状态
; 时钟每滴答 1 次,移动汽车 VELOCITY 个像素
(define (clock-tick-handler ws)
  (+ ws VELOCITY))

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
(define (end? ws)
  (> ws CAR-STOP-X))

; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick clock-tick-handler]
    [stop-when end?]))
