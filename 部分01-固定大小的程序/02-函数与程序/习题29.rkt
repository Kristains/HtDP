#lang racket

(define BASE-PRICE 5.0)
(define BASE-ATTENDESS 120)
(define PRICE-CHANGE 0.1)
(define ATTENDESS-CHANGE 15)
(define ATTENDESS-COST 1.5)

(define (attendees ticket-price)
  (- BASE-ATTENDESS (* (- ticket-price BASE-PRICE) (/ ATTENDESS-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* ATTENDESS-COST (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (* 1.5
        (+ 120
           (* (/ 15 0.1)
              (- 5.0 price))))))

(profit 5)
(profit 4)
(profit 3)
(profit 2)
(profit 1)

(profit2 5)
(profit2 4)
(profit2 3)
(profit2 2)
(profit2 1)
