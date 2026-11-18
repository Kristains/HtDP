;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题134) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

; 一个 List-of-booleans 是以下之一：
; – '()
; – (cons Boolean List-of-booleans)

; List-of-booleans -> Boolean
; 判断给定的字符串是否出现在输入的字符串中
(check-expect (contains? '() "a") #false)
(check-expect (contains? (cons "a" '()) "a") #true)
(check-expect (contains? (cons "b" '()) "a") #false)
(check-expect (contains? (cons "a" (cons "b" '())) "a") #true)
(check-expect (contains? (cons "a" (cons "b" '())) "b") #true)
(check-expect (contains? (cons "a" (cons "b" (cons "c" '()))) "d") #false)
(define (contains? sl s)
  (cond
    [(empty? sl) #false]
    [else
      (cond
        [(string=? (first sl) s) #true]
        [else (contains? (rest sl) s)])]))
