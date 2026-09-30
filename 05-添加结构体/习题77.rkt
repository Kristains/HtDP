#lang racekt

(define-struct time [hour minute second])
;; Time 是一个结构体:
;; 表示自午夜 0 点以来所经历的时间
;; (make-time Number Number Number)
;; (make-time h m s)
;; 其中小时 (hour) 表示为 h
;; 分钟 (minute) 表示为 m
;; 秒钟 (second) 表示为 s
