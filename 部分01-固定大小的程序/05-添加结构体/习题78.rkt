#lang racket

(define-struct word [letter1 letter2 letter3])
;; Word 是一个结构体:
;; (make-word String String String)
;; (make-word l1 l2 l3)
;; 其中第一个字母 (letter1) 表示为 l1
;; 其中第二个字母 (letter2) 表示为 l2
;; 其中第三个字母 (letter3) 表示为 l3
