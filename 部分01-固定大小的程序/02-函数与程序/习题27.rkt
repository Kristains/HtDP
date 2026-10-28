#lang racket

(define BASE-PRICE 5.0)
(define BASE-ATTENDESS 120)
(define PRICE-CHANGE 0.1)
(define ATTENDESS-CHANGE 15)
(define PRICE-COST 180)
(define ATTENDESS-COST 0.04)

(define (attendees ticket-price)
  (- BASE-ATTENDESS (* (- ticket-price BASE-PRICE) (/ ATTENDESS-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ PRICE-COST (* ATTENDESS-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 5)
(profit 3.5)
(profit 6)
