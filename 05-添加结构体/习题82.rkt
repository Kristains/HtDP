#lang racket

(define-struct word [letter1 letter2 letter3])
;; Word 是一个结构体:
;; (make-word String String String)
;; (make-word l1 l2 l3)
;; 其中第一个字母 (letter1) 表示为 l1
;; 其中第二个字母 (letter2) 表示为 l2
;; 其中第三个字母 (letter3) 表示为 l3

(define word1 (make-word "a" "b" "c"))
(define word2 (make-word "a" "b" "c"))
(define word3 (make-word "a" "o" "e"))

;; Word -> Word
;; 比较两个 Word ,如果其中的字母一致则保留 Word 字段中的内容,否则将字段内容变为 #false
(check-expect 
  (compare-word (make-word "a" "b" "c") 
                (make-word "a" "b" "c")) 
  (make-word "a" "b" "c"))
(check-expect 
  (compare-word (make-word "a" "b" "c") 
                (make-word "a" "e" "c")) 
  (make-word "a" #false "c"))

(define (compare-word w1 w2)
  (make-word
    (compare-letter (word-letter1 w1) (word-letter1 w2))
    (compare-letter (word-letter2 w1) (word-letter2 w2))
    (compare-letter (word-letter3 w1) (word-letter3 w2))))

;; Letter -> Letter
;; 比较两个字母,如果字母一致则返回字母,否则返回 #false
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)

(define (compare-letter l1 l2)
  (cond
    [(and (string? l1) (string? l2))
     (cond
       [(string=? l1 l2) l1]
       [else #false])]
    [else #false]))


