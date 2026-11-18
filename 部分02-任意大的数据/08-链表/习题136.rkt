;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题136) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(define-struct pair [left right])
; ConsPair 是结构体
;     (make-pair Any Any)

; ConsOrEmpty 是下列之一:
; -- '()
; -- (make-pair Any ConsOrEmpty)
; 解释: ConsOrEmpty 是所有链表的类

; Any Any -> ConsPair
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

; ConsOrEmpty -> Any
; 提取输入 pair 的 left 部分
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> Any
; 提取输入 pair 的 right 部分
(define (our-rest a-list)
  (if (empty? a-list)
      a-list
      (pair-right a-list)))

(our-first (our-cons "a" '()))
;->
(our-first
 (cond
  ((empty? '()) (make-pair "a" '()))
  ((pair? '()) (make-pair "a" '()))
  (else
   (error "cons: second argument ..."))))
;->
(our-first
 (cond
  (#true (make-pair "a" '()))
  ((pair? '()) (make-pair "a" '()))
  (else
   (error "cons: second argument ..."))))
;->
(our-first (make-pair "a" '()))
;->
(if (empty? (make-pair "a" '()))
  (error 'our-first "...")
  (pair-left (make-pair "a" '())))
;->
(if #false
  (error 'our-first "...")
  (pair-left (make-pair "a" '())))
;->
(pair-left (make-pair "a" '()))
;->
"a"

(our-rest (our-cons "a" '()))
;->
(our-rest
 (cond
  ((empty? '()) (make-pair "a" '()))
  ((pair? '()) (make-pair "a" '()))
  (else
   (error "cons: second argument ..."))))
;->
(our-rest
 (cond
  (#true (make-pair "a" '()))
  ((pair? '()) (make-pair "a" '()))
  (else
   (error "cons: second argument ..."))))
;->
(our-rest (make-pair "a" '()))
;->
(if (empty? (make-pair "a" '()))
  (make-pair "a" '())
  (pair-right (make-pair "a" '())))
;->
(if #false
  (make-pair "a" '())
  (pair-right (make-pair "a" '())))
;->
(pair-right (make-pair "a" '()))
;->
'()
