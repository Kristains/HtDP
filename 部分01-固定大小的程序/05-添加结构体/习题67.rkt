#lang racket

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

;; 解释
; 定义了 SPEED 常量，值为 3
; 定义了一个结构体 balld，该结构体有两个参数，分别为 location,direction
; 调用了构造函数 make-balld 创建了一个新的实例
; 该实例的参数值为 10 (位置)，"up" (方向)

(define balld1 (make-balld SPEED "up"))
(define balld2 (make-balld SPEED "down"))
