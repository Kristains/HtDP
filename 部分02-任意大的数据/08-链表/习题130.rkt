;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题130) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

; 一个 List-of-names（名字列表）是以下之一：
; – '()
; – (cons String List-of-names)
; 解释：一个受邀者名单，按姓氏排列

(cons "Alice"
      (cons "Bob"
            (cons "Clare"
                  (cons "Ed"
                        (cons "Frank"
                              cons '())))))

; 解释一下为什么
; (cons "1" (cons "2" '()))
; 是 List-of-names 的元素，而 (cons 2 '()) 不是

; 回答
; List-of-names 的其中一个定义是 (cons String List-of-names)
; 而 (cons 2 '()) 是 (cons Number List-of-names)
; 所以它不是 List-of-names 的元素
