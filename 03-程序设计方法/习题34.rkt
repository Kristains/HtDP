#lang racket
;;P54


;;String -> String
;;从非空字符串中提取出第一个字符
;;无需担心空字符串的情况
;;输入: helloworld, 期望输出: h
;;输入: apple, 期望输出: a
(define (string-first s)
  (substring s 0 1))
