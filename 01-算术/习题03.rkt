#lang racket
(requirt 2htdp/image)
;; P24 [习题3]
(define str "helloworld")
(define i 5)

(define (append-underline-to word position) 
  (string-append (substring word 0 position) "_" (substring word position))
  )

(append-underline-to str i)
