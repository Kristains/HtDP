;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题119) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; 解释下列语句为什么在语法上是非法的表达式

(define (f "x") x)
;; - f 是 variables（变量）
;; - "x" 是 value（值）
;; - (define (variable value) expr) 不是合法表达式

(define (f x y z) (x))
;; - f、x、y、z 是 variables（变量）
;; - x 是 expr（表达式）
;; - (define (variable variable variable variable) (variable)) 不是合法表达式
