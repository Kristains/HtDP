#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (render 50) (place-image CAT1 50 Y-CAT BACKGROUND))
(check-expect (render 200) (place-image CAT1 200 Y-CAT BACKGROUND))

;; 定义区
(define CAT1 (bitmap "./images/cat1.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))

(define VELOCITY 3)

(define BACKGROUND-WIDTH (* CAT-WIDTH 8))
(define BACKGROUND-HEIGHT (* CAT-HEIGHT 3))
(define BACKGROUND
   (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))

(define Y-CAT (- BACKGROUND-HEIGHT (/ CAT-HEIGHT 2)))
(define X-START-CAT 0)
; WorldState -> Image
; 获取当前世界状态的图像
(define (render ws)
  (place-image CAT1 ws Y-CAT BACKGROUND))

; WorldState -> WorldState
; 时钟每滴答一下,big-bang 从(clock-tick-handler ws)
; 获取世界的下一个状态
; 时钟每滴答 1 次,位置向右变动 VELOCITY 个像素
(define (clock-tick-handler ws)
  (modulo
   (+ ws VELOCITY)
   (round BACKGROUND-WIDTH)))

; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick clock-tick-handler]
    ))
