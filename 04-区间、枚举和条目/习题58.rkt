#lang racket

;; 测试函数
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax (- LOWER-BOUND-1 1)) 0)
(check-expect (sales-tax LOWER-BOUND-1) (* RATE-1 LOWER-BOUND-1))
(check-expect (sales-tax 1282) (* RATE-1 1282))
(check-expect (sales-tax (- LOWER-BOUND-2 1)) (* RATE-1 9999))
(check-expect (sales-tax LOWER-BOUND-2) (* RATE-2 LOWER-BOUND-2))
(check-expect (sales-tax 12017) (* RATE-2 12017))

;; 定义区
(define LOWER-BOUND-1 1000)
(define LOWER-BOUND-2 10000)

(define RATE-1 0.05)
(define RATE-2 0.08)

;; Price -> Number
;; 计算对价格（price）收取的税额
(define (sales-tax price)
  (cond
    [(and (<= 0 price) (< price LOWER-BOUND-1)) 0]
    [(and (<= LOWER-BOUND-1 price) (< price LOWER-BOUND-2)) (* RATE-1 price)]
    [(>= price LOWER-BOUND-2) (* RATE-2 price)]))
