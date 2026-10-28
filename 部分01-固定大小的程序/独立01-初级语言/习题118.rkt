;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题118) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; 解释下列语句为什么在语法上是合法的表达式

(define (f x) x)
;; - f 和 x 是 variables（变量）
;; - variable（变量）是 expr（表达式）
;; - (define (variable variable) expr) 是一个 definition（定义）


(define (f x) y)
;; - f、x、y 是 variables（变量）
;; - y 是 expr（表达式）
;; - (define (variable variable) expr) 是一个 definition（定义）


(define (f x y) 3)
;; - f、x、y 是 variables（变量）
;; - 3 是一个 value（值）
;; - value（值）是 expr（表达式）
;; - (define (variable variable variable) expr) 是一个 definition（定义）
