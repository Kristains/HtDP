#lang racket
(require 2htdp/image)
;; p29 [习题7]

(define cat (bitmap "./images/cat.png"))

(define (pic-tall-or-wide pic)
  (if (> (image-height pic) (image-width pic)) "tall" "wide"))

(pic-tall-or-wide cat)
