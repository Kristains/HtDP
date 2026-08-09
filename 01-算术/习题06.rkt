#lang racket
(requirt 2htdp/image)
;; p26 [习题6]

(define cat (bitmap "./images/cat.png")) 

(* (image-width cat) (image-height cat))
