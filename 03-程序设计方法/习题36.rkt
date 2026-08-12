#lang racket
;;P54

;; 1. 表明你希望如何将信息表示为数据。

; 我们使用 Number 数据类型来表示图像像素数量。


;; 2. 写出：
;;   - 签名
;;   - 目的声明
;;   - 函数头

; Image -> Number
; 从给定的图像中计算出像素数量
; (define (f img) 0)


;; 3. 用一些功能示例来说明签名和用途说明。

; (square 10 "solid" "yellow") -> 100
; (rectangle 20 30 "outline" "red") -> 600


;; 4. 写出函数原型：函数头和函数体模板。

; (define (image-area img) (... img ...))

;; 5. 写出函数。
(require 2htdp/image)

(define (image-area img)
  (* (image-width img) (image-height img)))


;; 6. 在第3步的示例上测试该函数。

(image-area (square 10 "solid" "yellow"))
(image-area (rectangle 20 30 "outline" "red"))
