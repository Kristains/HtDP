;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题120) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; 区分下列语句哪些在语法上是合法的表达式，哪些是非法的表达式

(x)
;; - x 是 variables（变量）
;; - variables（变量）同时也是 expr（表达式）
;; - (expr) 不是合法表达式

(+ 1 (not x))
;; - 1 是 value（值） 
;; - value（值）同时也是 expr（表达式）
;; - x 是 variables（变量）
;; - variables（变量）同时也是 expr（表达式）
;; - not 是 primitive（基元）
;; - (not x) 是 (primitive expr)
;; - 也就是 expr（表达式）
;; - 所以 (+ 1 (not x)) 就是 (primitive expr expr)
;; - (primitive expr expr) 是 expr（表达式）
;; - 但是这个表达式是无法运行的
;; - 因为 + 是用于数字的
;; - (not x) 所输出的是 Boolean 类型

(+ 1 2 3)
;; - 1、2、3 是 value（值） 
;; - value（值）同时也是 expr（表达式）
;; - + 是 primitive（基元）
;; - (primitive expr expr expr) 是 expr（表达式）
;; - 是合法的表达式
;; - 结果为 6
