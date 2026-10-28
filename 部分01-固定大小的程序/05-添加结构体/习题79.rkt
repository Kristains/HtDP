#lang racket

;; Color 是下列之一:
;; — "white"
;; — "yellow"
;; — "orange"
;; — "green"
;; — "red"
;; — "blue"
;; — "black"

(define WHITE "white")
(define RED "red")


;; H 是介于 0 和 100 之间的 Number
;; 解释: 代表快乐值

(define MAX 100)
(define MIN 0)
(define MID 50)


(define-struct person [fstname lstname male?])
;; Person 是一个结构体:
;;   (make-person String String Boolean)

(define-struct smith (make-person "Tom" "Smith" #true))

(person-fstname smith)
(person-lstname smith)
(person-male? smith)


(define-struct dog [owner name age happiness])
;; Dog 是一个结构体:
;;   (make-dog Person String PositiveInteger H)

(define puppy (make-dog smith "Puppy" 2 MAX))

(dog-owner puppy)
(person-lstname (dog-owner puppy))
(dog-name puppy)
(dog-age puppy)
(dog-happiness puppy)


;; Weapon 是下列之一:
;; — #false
;; — Posn
;; 解释: #false 表示导弹还未发射
;; Posn 表示它还在飞行中

(define NUCLEAR #false)
(define TARGET (make-posn 30 50))
