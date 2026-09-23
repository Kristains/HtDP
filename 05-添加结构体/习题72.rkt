#lang racket

(define-struct phone [area number])
;; Phone 是一个结构体:
;;   (make-phone Number String)
;; 解释:
;; area 是区域代码,
;; number 是本地电话号码.

(define-struct phone# [area switch num])
;; Phone# 是一个结构体:
;;   (make-phone# Number Number Number)
;; 解释:
;; area 是区域代码,区间在[000, 999],
;; switch 是街区电话交换机的代码,区间在[000, 999],
;; num 街区交换机之内的电话号码,区间在[0000, 9999].
