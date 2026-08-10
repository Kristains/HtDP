#lang racket
(require 2htdp/image)

(define (in element)
  (cond
  [(string? element) (string-length element)]
  [(image? element) (* (image-width element) (image-height element))]
  [(number? element) (if (> element 0) (- element 1) element)]
  [(boolean? element) (if element 10 20)]
  [else "未知数据"])
)

(in "helloworld")
(in (bitmap ./images/cat.png))
(in 20)
(in 0)
(in #true)
