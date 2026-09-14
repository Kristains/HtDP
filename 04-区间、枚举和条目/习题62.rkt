#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN)   CLOSED)

(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a")   OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

(check-expect (door-render LOCKED) (text LOCKED 40 "red"))
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(check-expect (door-render OPEN)   (text OPEN 40 "red"))

;; 定义区
; DoorState 是下列之一:
; -- LOCKED
; -- CLOSED
; -- OPEN
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN   "open")

;; DoorState —> DoorState
;; 时钟滴答一次之后,关闭被打开的门
(define (door-closer state-of-door)
  (cond [(string=? state-of-door LOCKED) LOCKED]
        [(string=? state-of-door CLOSED) CLOSED]
        [(string=? state-of-door OPEN)   CLOSED]))

;; DoorState KeyEven —> DoorState
;; 将键盘事件 k 转换为对状态 s 的动作
(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k)) CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k)) LOCKED]
    [(and (string=? CLOSED s) (string=? " " k)) OPEN]
    [else s]))

;; DoorState —> Image
;; 将状态 s 转换成显示大字的图像
(define (door-render s)
  (text s 40 "red"))

;; TrafficLight -> TrafficLight
;; 模拟基于时钟的交通灯
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key  door-action]
    [to-draw door-render]))
