#lang racket
;;P54

;; 1. 表明你希望如何将信息表示为数据。

; 我们使用 String 数据类型来表示文本信息。


;; 2. 写出：
;;   - 签名
;;   - 目的声明
;;   - 函数头

; String -> String
; 从非空字符串移除最后一个字符后的字符串
; (define (f str) "ab")


;; 3. 用一些功能示例来说明签名和用途说明。

; "z" -> ""
; "0-day-1" -> "0-day-"
; "Fun FacT" -> "Fun Fac"


;; 4. 写出函数原型：函数头和函数体模板。

; (define (string-remove-last s) (... s ...))

;; 5. 写出函数。

(define (string-remove-last s)
  (substring s 0 (- (string-length s) 1)))


;; 6. 在第3步的示例上测试该函数。

(string-remove-last "z")

(string-remove-last "0-day-1")

(string-remove-last "Fun FacT")
