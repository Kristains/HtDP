#lang racket
(require 2htdp/image)

(define (image-area pic)
  (* (image-width pic) (image-height pic)))


(define cat (bitmap ./images/cat.png))
(image-area cat)
