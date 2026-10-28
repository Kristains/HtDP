#lang racket
;; P24 [习题4]
(define (delete-str-to word position)
  (string-append (substring word 0 position) (substring word (+ position 1)))
  )

(delete-str-to str i)
