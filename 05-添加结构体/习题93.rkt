#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; Definition

(define SCENE-WIDTH 400)
(define SCENE-HEIGHT 300)
(define SCENE
  (beside (empty-scene SCENE-WIDTH SCENE-HEIGHT "green")
          (empty-scene SCENE-WIDTH SCENE-HEIGHT "white")
          (empty-scene SCENE-WIDTH SCENE-HEIGHT "red")))

(define-struct VCham [pic color pos-x happy-num])
;; (make-VCat Image Number String Number)
;; pic 显示变色龙的样子, pos-x 记录变色龙的横坐标, color 记录变色龙的颜色, happy-num 记录变色龙的快乐指数

(define CHAM (bitmap ./images/cham.png)
(define CHAM-WIDTH (image-width CHAM))
(define CHAM-HEIGHT (image-height CHAM))
(define Y-CHAM (- SCENE-HEIGHT (/ CHAM-HEIGHT 2)))
(define CHAM-VELOCITY 1)
(define VCHAM (make-VCham CHAM "s" (/ CHAM-WIDTH 2) 100))

(define RED-BACKGROUND
  (rectangle (image-width CHAM)
             (image-height CHAM)
             "solid"
             "red"))
(define BLUE-BACKGROUND
  (rectangle (image-width CHAM)
             (image-height CHAM)
             "solid"
             "blue"))
(define GREEN-BACKGROUND
  (rectangle (image-width CHAM)
             (image-height CHAM)
             "solid"
             "green"))

(define HAPPY-MAX_HEIGHT 100)
(define HAPPY-WIDTH 30)
(define X-HAPPY 35)
(define Y-HAPPY 80)
(define HAPPY-STATUS_COLOR "red")
(define HAPPY-BACKGROUND_COLOR "orange")
(define HAPPY-VELOCITY 0.1)
(define HAPPY-INCREASE_DOWN 5)
(define HAPPY-INCREASE_UP 3)


;; Function

; VCham -> Image
; 获取当前世界状态的图像
(check-expect (render VCHAM)
              (place-image (happy-layer VCHAM) X-HAPPY Y-HAPPY
                           (place-image (color-cham VCHAM) (VCham-pos-x VCHAM) Y-CHAM 
                           SCENE)))
(define (render vc)
  (place-image (happy-layer vc) X-HAPPY Y-HAPPY
             (place-image (color-cham vc) (VCham-pos-x vc) Y-CHAM
             SCENE)))

; VCham -> Image
; 获取快乐指数的图像
(check-expect (happy-layer VCHAM)
              (overlay/align "middle" "bottom"
                 (rectangle HAPPY-WIDTH (VCham-happy-num VCHAM) "solid" HAPPY-STATUS_COLOR)
                 (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR)))
(define (happy-layer vc)
  (overlay/align "middle" "bottom"
                 (rectangle HAPPY-WIDTH (VCham-happy-num vc) "solid" HAPPY-STATUS_COLOR)
                 (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR)))

; VCham -> Image
; 展示不同颜色的变色龙图像
(check-expect (color-cham (make-VCham CHAM "r" (/ CHAM-WIDTH 2) 100))
              (overlay (VCham-pic VCHAM) RED-BACKGROUND))
(check-expect (color-cham (make-VCham CHAM "b" (/ CHAM-WIDTH 2) 100))
              (overlay (VCham-pic VCHAM) BLUE-BACKGROUND))
(check-expect (color-cham (make-VCham CHAM "g" (/ CHAM-WIDTH 2) 100))
              (overlay (VCham-pic VCHAM) GREEN-BACKGROUND))
(check-expect (color-cham (make-VCham CHAM "s" (/ CHAM-WIDTH 2) 100))
              CHAM)
(define (color-cham vc)
  (cond
    [(string=? "r" (VCham-color vc))
     (overlay (VCham-pic vc) RED-BACKGROUND)]
    [(string=? "b" (VCham-color vc))
     (overlay (VCham-pic vc) BLUE-BACKGROUND)]
    [(string=? "g" (VCham-color vc))
     (overlay (VCham-pic vc) GREEN-BACKGROUND)]
    [(string=? "s" (VCham-color vc))
     (VCham-pic vc)]))

; VCham -> VCham
; 时钟每滴答一下,big-bang 从(clock-tick-handler vc)
; 获取变色龙的下一个状态
(check-expect (clock-tick-handler VCHAM)
              (make-VCham (VCham-pic VCHAM)
                          (VCham-color VCHAM)
                          (update-pos-cham VCHAM)
                          (update-happy VCHAM)))
(define (clock-tick-handler vc)
  (make-VCham (VCham-pic vc)
              (VCham-color vc)
              (update-pos-cham vc)
              (update-happy vc)))

; VCham -> Number
; 更新变色龙当前的位置
(check-expect (update-pos-cham VCHAM)
              (+
                (VCham-pos-x VCHAM)
                CHAM-VELOCITY))
(check-expect (update-pos-cham (make-VCham CHAM "s" (* SCENE-WIDTH 3) 100))
              (/ CHAM-WIDTH 2))
(define (update-pos-cham vc)
  (if (> (VCham-pos-x vc)
         (- (* SCENE-WIDTH 3) (/ CHAM-WIDTH 2)))
      (/ CHAM-WIDTH 2)
      (+ (VCham-pos-x vc) CHAM-VELOCITY)))

; VCham -> Number
; 更新变色龙当前的快乐指数
(check-expect (update-happy VCHAM)
              (- (VCham-happy-num VCHAM) HAPPY-VELOCITY))
(check-expect (update-happy (make-VCham CHAM "s" 0 (+ 20 HAPPY-MAX_HEIGHT)))
              HAPPY-MAX_HEIGHT)
(check-expect (update-happy (make-VCham CHAM "s" 0 (- 20 HAPPY-MAX_HEIGHT)))
              0)
(define (update-happy vc)
  (cond
  [(< (VCham-happy-num vc) 0) 0]
  [(> (VCham-happy-num vc) HAPPY-MAX_HEIGHT) HAPPY-MAX_HEIGHT]
  [else (- (VCham-happy-num vc) HAPPY-VELOCITY)]))

; VCham KeyEvent -> VCham
; 如果给定的 key 是 "down"
; 执行 increase-score 函数, 用以提升变色龙的快乐指数
; 如果给定的 key 是 "r", "b", "g" 或者 "s"
; 更改 VCham 结构体的 color ，用以更改变色龙的颜色
(check-expect (key-handler VCHAM "down")
              (happy-increase-score VCHAM))
(check-expect (key-handler (make-VCham CHAM "s" 0 (+ 20 HAPPY-MAX_HEIGHT)) "down")
              (make-VCham CHAM "s" 0 HAPPY-MAX_HEIGHT))
(check-expect (key-handler (make-VCham CHAM "s" 0 100) "r")
              (make-VCham CHAM "r" 0 100))
(check-expect (key-handler (make-VCham CHAM "s" 0 100) "b")
              (make-VCham CHAM "b" 0 100))
(check-expect (key-handler (make-VCham CHAM "s" 0 100) "g")
              (make-VCham CHAM "g" 0 100))
(check-expect (key-handler (make-VCham CHAM "r" 0 100) "s")
              (make-VCham CHAM "s" 0 100))

(define (key-handler vc key)
  (cond
    [(key=? key "down") (happy-increase-score vc)]
    [(key=? key "r") (make-VCham (VCham-pic vc) "r" (VCham-pos-x vc) (VCham-happy-num vc))]
    [(key=? key "b") (make-VCham (VCham-pic vc) "b" (VCham-pos-x vc) (VCham-happy-num vc))]
    [(key=? key "g") (make-VCham (VCham-pic vc) "g" (VCham-pos-x vc) (VCham-happy-num vc))]
    [(key=? key "s") (make-VCham (VCham-pic vc) "s" (VCham-pos-x vc) (VCham-happy-num vc))]
    [else vc] ))

; VCham Number -> VCham
; 增加变色龙的快乐指数
; 如果超过了 MAX_HEIGHT 就输出 MAX_HEIGHT
(check-expect (happy-increase-score (make-VCham CHAM "s" 50 (+ HAPPY-MAX_HEIGHT 20)))
              (make-VCham CHAM "s" 50 HAPPY-MAX_HEIGHT))
(check-expect (happy-increase-score (make-VCham CHAM "s" 50 (- HAPPY-MAX_HEIGHT 20)))
              (make-VCham CHAM "s" 50 (- HAPPY-MAX_HEIGHT 18)))
(define (happy-increase-score vc)
  (if (>= (+ (VCham-happy-num vc) 2) HAPPY-MAX_HEIGHT)
      (make-VCham (VCham-pic vc)
                  (VCham-color vc)
                  (VCham-pos-x vc)
                  HAPPY-MAX_HEIGHT)
      (make-VCham (VCham-pic vc)
                  (VCham-color vc)
                  (VCham-pos-x vc)
                  (+ (VCham-happy-num vc) 2))))

; VCham -> Boolean
; 当变色龙的快乐指数为 0 就停止程序
(check-expect (end? VCHAM) #false)
(check-expect (end? (make-VCham CHAM "s" 50 0)) #true)
(define (end? vc)
  (= (VCham-happy-num vc) 0))
  
; VCham -> VCat
; 从变色龙的初始状态启动程序
(define (happy-cham vc)
  (big-bang vc
    [to-draw render]
    [on-tick clock-tick-handler]
    [on-key key-handler]
    [stop-when end?]
    ))
