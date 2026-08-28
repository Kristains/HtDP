#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (render 20) (overlay/align "middle" "bottom"
                 (rectangle WIDTH 20 "solid" STATUS_COLOR)
                 (rectangle WIDTH MAX_HEIGHT "solid" BACKGROUND_COLOR)))

(check-expect (clock-tick-handler 20) (- 20 VELOCITY))
(check-expect (clock-tick-handler (+ 20 MAX_HEIGHT)) MAX_HEIGHT)
(check-expect (clock-tick-handler -10) 0)

(check-expect (key-handler 10 "down") (increase-score 10 INCREASE_DOWN))
(check-expect (key-handler (+ 20 MAX_HEIGHT) "up") (increase-score (+ 20 MAX_HEIGHT) INCREASE_UP))

(check-expect (increase-score MAX_HEIGHT INCREASE_DOWN) MAX_HEIGHT)
(check-expect (increase-score 20 INCREASE_UP) (+ 20 (/ 20 INCREASE_UP)))

;; 定义区
(define MAX_HEIGHT 100)
(define WIDTH 30)
(define STATUS_COLOR "red")
(define BACKGROUND_COLOR "orange")
(define VELOCITY 0.1)
(define INCREASE_DOWN 5)
(define INCREASE_UP 3)

; WorldState -> Image
; 获取当前世界状态的图像
(define (render ws)
  (overlay/align "middle" "bottom"
                 (rectangle WIDTH ws "solid" STATUS_COLOR)
                 (rectangle WIDTH MAX_HEIGHT "solid" BACKGROUND_COLOR)))

; WorldState -> WorldState
; 时钟每滴答一下,big-bang 从(clock-tick-handler ws)
; 获取世界的下一个状态
; 时钟每滴答 1 次,向下变动 VELOCITY 个单位
; 当下降到 0 以下时，保持 0 不变
; 当上升到 MAX_HEIGHT 以上时，保持 MAX_HEIGHT 不变
(define (clock-tick-handler ws)
  (cond
  [(< ws 0) 0]
  [(> ws MAX_HEIGHT) MAX_HEIGHT]
  [else (- ws VELOCITY)]))

; WorldState Number NUmber String -> WorldState
; 如果给定的 key 是 "down" 或者是 "up"
; 执行相应的 increase-score 函数
(define (key-handler ws key)
  (cond
    [(key=? key "down") (increase-score ws INCREASE_DOWN)]
    [(key=? key "up") (increase-score ws INCREASE_UP)]
    [else ws] )
  )

; WorldState Number -> WorldState
; 根据 add 的值来增加 ws 的值
; 如果超过了 MAX_HEIGHT 就输出 MAX_HEIGHT
(define (increase-score ws add)
  (if (> (+ ws (/ ws add)) MAX_HEIGHT)
        MAX_HEIGHT
        (+ ws (/ ws add))))

(define (end? ws)
  (= ws 0))
  
; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick clock-tick-handler]
    [on-key key-handler]
    [stop-when end?]
    ))
