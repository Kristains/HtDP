;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题124) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; 分步计算以下程序

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
(define TOTAL (+ PRICE SALES-TAX))
;->
(define PRICE 5)
(define SALES-TAX (* 0.08 5))
(define TOTAL (+ PRICE SALES-TAX))
;->
(define PRICE 5)
(define SALES-TAX 0.4)
(define TOTAL (+ PRICE SALES-TAX))
;->
(define PRICE 5)
(define SALES-TAX 0.4)
(define TOTAL (+ 5 0.4))
;->
(define PRICE 5)
(define SALES-TAX 0.4)
(define TOTAL 5.4)


;; 以下程序的求值是否会报错？
(define COLD-F 32)
(define COLD-C (fahrenheit->celsius COLD-F))
(define (fahrenheit->celsius f)
 (* 5/9 (- f 32)))

; 回答：会报错，因为 fahrenheit->celsius 的使用在定义之前


;; 下面这个程序呢？
(define LEFT -100)
(define RIGHT 100)
(define (f x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (f LEFT))
(define f@RIGHT (f RIGHT))

; 回答：不会
