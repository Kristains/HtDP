#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数

(check-expect
 (show "resting")
 (place-image ROCKET 10 ROCKET-GROUNDED-Y BACKG))

(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 ROCKET-GROUNDED-Y BACKG)))

(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 ROCKET-CENTER) BACKG))

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -2 "a") -2)
(check-expect (launch 3 " ") 3)

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 11) (- 11 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(check-expect (end? "resting") #false)
(check-expect (end? (/ HEIGHT 2)) #false)
(check-expect (end? 0) #true)
;; 定义区

(define WIDTH 100)
(define HEIGHT 300)
(define BACKG (empty-scene WIDTH HEIGHT))

(define ROCKET (rectangle 5 30 "solid" "red"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))
(define ROCKET-GROUNDED-Y (- HEIGHT ROCKET-CENTER))

(define YDELTA 3)

; LRCD -> Image
; 将状态呈现为停止或飞行中的火箭
(define (show x)
  (cond
    [(string? x)
     (draw-rocket ROCKET-GROUNDED-Y)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
              10 (* 3/4 WIDTH)
              (draw-rocket ROCKET-GROUNDED-Y))]
    [(>= x 0)
     (draw-rocket (- x ROCKET-CENTER))]))

; Number -> Image
; 在高度 y 处画火箭
(define (draw-rocket y)
  (place-image ROCKET 10 y BACKG))

; LRCD KeyEvent -> LRCD
; 当按下空格键时，如果火箭仍停止，则开始倒计时
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; 如果火箭已经在飞行，将其提升 YDELTA 像素
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; LRCD -> Boolean
; 判断程序是否结束:当火箭完全飞出屏幕顶部时返回 #true
(define (end? x)
  (and (number? x) (= x 0)))

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly]
    [stop-when end?]))
