#lang racket

(check-expect (manhattam-distance (make-posn 3 5)) 8)
(check-expect (manhattam-distance (make-posn 3 0)) 3)
(check-expect (manhattam-distance (make-posn 0 5)) 5)

(define (manhattam-distance ap)
  (+ (posn-x ap)
     (posn-y ap))
