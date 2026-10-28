;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题115) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Any -> Boolean
; 给定值是否为 TrafficLight 元素
(check-expect (light? "red") #true)
(check-expect (light? "green") #true)
(check-expect (light? "yellow") #true)
(check-expect (light? "blue") #false)
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE "traffic light expected, given some other value")
(define MESSAGE-1 "light=? invalid first argument: expected light, got an unexpected value")
(define MESSAGE-2 "light=? invalid second argument: expected light, got an unexpected value")

; Any Any -> Boolean
; 两个值是否为 TrafficLight 元素
; 如果是，它们是否相等
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error
       (cond
         [(light? a-value) MESSAGE-2]
         [(light? another-value) MESSAGE-1]
         [else MESSAGE]))))