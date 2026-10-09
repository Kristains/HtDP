#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; Definition

(define-struct VCat [pic pos-x happy-num])
;; (make-VCat Image Number Number)
;; pic 显示猫的样子, pos-x 记录猫的横坐标, happy-num 记录猫的快乐指数

(define SCENE-WIDTH 400)
(define SCENE-HEIGHT 300)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
(define CAT1 (bitmap "./images/cat1.png"))
(define CAT2 (bitmap "./images/cat2.png"))
(define CAT3 (bitmap "./images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define Y-CAT (- SCENE-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-VELOCITY 1)

(define VCAT (make-VCat CAT1 20 50))
(define VCAT-START (make-VCat CAT1 0 100))

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

; VCat -> Image
; 获取当前世界状态的图像
(check-expect (render VCAT)
              (place-image (happy-layer VCAT) X-HAPPY Y-HAPPY
                           (place-image (VCat-pic VCAT) (VCat-pos-x VCAT) Y-CAT 
                           SCENE)))
(define (render vc)
  (place-image (happy-layer vc) X-HAPPY Y-HAPPY
             (place-image (VCat-pic vc) (VCat-pos-x vc) Y-CAT
             SCENE)))

; VCat -> Image
; 获取快乐指数的图像
(check-expect (happy-layer VCAT)
              (overlay/align "middle" "bottom"
                 (rectangle HAPPY-WIDTH (VCat-happy-num VCAT) "solid" HAPPY-STATUS_COLOR)
                 (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR)))
(define (happy-layer vc)
  (overlay/align "middle" "bottom"
                 (rectangle HAPPY-WIDTH (VCat-happy-num vc) "solid" HAPPY-STATUS_COLOR)
                 (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR)))

; VCat -> VCat
; 时钟每滴答一下,big-bang 从(clock-tick-handler vc)
; 获取猫的下一个状态
(check-expect (clock-tick-handler VCAT)
              (make-VCat (now-cat VCAT)
                         (now-pos-cat VCAT)
                         (now-happy VCAT)))
(define (clock-tick-handler vc)
  (make-VCat (now-cat vc)
             (now-pos-cat vc)
             (now-happy vc)))

; VCat -> Image
; 获取猫当前的图像
(check-expect (now-cat VCAT) CAT3)
(define (now-cat vc)
  (cond
    [(odd? (VCat-pos-x vc)) CAT2]
    [else CAT3]))

; VCat -> Number
; 获取猫当前的位置
(check-expect (now-pos-cat VCAT)
              (modulo
               (+ (VCat-pos-x VCAT) CAT-VELOCITY)
               (round SCENE-WIDTH)))
(define (now-pos-cat vc)
  (modulo
   (+ (VCat-pos-x vc) CAT-VELOCITY)
   (round SCENE-WIDTH)))

; VCat -> Number
; 获取猫当前的快乐指数
(check-expect (now-happy VCAT)
              (- (VCat-happy-num VCAT) HAPPY-VELOCITY))
(check-expect (now-happy (make-VCat CAT1 0 (+ 20 HAPPY-MAX_HEIGHT)))
              HAPPY-MAX_HEIGHT)
(check-expect (now-happy (make-VCat CAT1 0 (- 20 HAPPY-MAX_HEIGHT)))
              0)
(define (now-happy vc)
  (cond
  [(< (VCat-happy-num vc) 0) 0]
  [(> (VCat-happy-num vc) HAPPY-MAX_HEIGHT) HAPPY-MAX_HEIGHT]
  [else (- (VCat-happy-num vc) HAPPY-VELOCITY)]))

; VCat KeyEvent -> VCat
; 如果给定的 key 是 "down" 或者是 "up"
; 执行相应的 increase-score 函数, 用以提升或下降猫的快乐指数
(check-expect (key-handler VCAT "down")
              (happy-increase-score VCAT HAPPY-INCREASE_DOWN))
(check-expect (key-handler (make-VCat CAT1 0 (+ 20 HAPPY-MAX_HEIGHT)) "up")
              (happy-increase-score (make-VCat CAT1 0 (+ (VCat-happy-num VCAT) HAPPY-MAX_HEIGHT))
                              HAPPY-INCREASE_UP))
(define (key-handler vc key)
  (cond
    [(key=? key "down") (happy-increase-score vc HAPPY-INCREASE_DOWN)]
    [(key=? key "up") (happy-increase-score vc HAPPY-INCREASE_UP)]
    [else vc] ))

; VCat Number -> VCat
; 根据 add 的值来以不同程度增加猫的快乐指数
; 如果超过了 MAX_HEIGHT 就输出 MAX_HEIGHT
(check-expect (happy-increase-score (make-VCat CAT1 50 (+ HAPPY-MAX_HEIGHT 20))
                              HAPPY-INCREASE_DOWN)
              (make-VCat CAT1 50 HAPPY-MAX_HEIGHT))
(check-expect (happy-increase-score VCAT HAPPY-INCREASE_UP)
              (make-VCat CAT1
                         20
                         (+ (VCat-happy-num VCAT)
                            (/ (VCat-happy-num VCAT)
                               HAPPY-INCREASE_UP))))
(define (happy-increase-score vc add)
  (if (> (+ (VCat-happy-num vc) (/ (VCat-happy-num vc) add)) HAPPY-MAX_HEIGHT)
        (make-VCat (VCat-pic vc)
                   (VCat-pos-x vc)
                   HAPPY-MAX_HEIGHT)
        (make-VCat (VCat-pic vc)
                   (VCat-pos-x vc)
                   (+ (VCat-happy-num vc) (/ (VCat-happy-num vc) add)))))

; VCat -> Boolean
; 当猫的快乐指数为 0 就停止程序
(check-expect (end? VCAT) #false)
(check-expect (end? (make-VCat CAT1 50 0)) #true)
(define (end? vc)
  (= (VCat-happy-num vc) 0))
  
; VCat -> VCat
; 从猫的初始状态(x坐标为 0,快乐指数为 100)启动程序
(define (happy-cat vc)
  (big-bang vc
    [to-draw render]
    [on-tick clock-tick-handler 0.2]
    [on-key key-handler]
    [stop-when end?]
    ))
