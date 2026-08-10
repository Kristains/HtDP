#lang racket

(define (string-last s)
  (string (string-ref s (- (string-length s) 1))))

(string-last "hello")
