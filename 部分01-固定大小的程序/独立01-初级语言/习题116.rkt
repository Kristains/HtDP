;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题116) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; 解释下列语句为什么在语法上是合法的表达式


x
;; - x 是一个 variable（变量）
;; - 文法中 expr = variable 是一条产生式
;; - 所以 x 是合法表达式

(= y z)
;; - y 和 z 是 variables（变量），而 variable（变量）是 expr（表达式）
;; - = 是一个 primitive（基元）
;; - 整个句子匹配 expr 的产生式 (primitive expr expr ...)
;; - 所以 (= y z) 是合法表达式

(= (= y z) 0)
;; - (= y z) 是 expr（表达式），见上一条
;; - 0 是一个 value（常量），而 value（常量）是 expr（表达式）
;; - = 是一个 primitive（基元）
;; - 整个句子匹配 expr 的产生式 (primitive expr expr ...)
;; - 所以 (= (= y z) 0) 是合法表达式
