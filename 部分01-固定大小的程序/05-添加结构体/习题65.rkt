#lang racket

(define-struct movie [title producer year])

;; 构造函数
; make-movie

;; 选择函数
; movie-title
; movie-producer
; movie-year

;; 谓词
; movie?


;; Definition 2.
(define-struct person [name hair eyes phone])

;; 构造函数
; make-person

;; 选择函数
; person-name
; person-hair
; person-eyes
; person-phone

;; 谓词
; person?


;; Definition 3.
(define-struct pet [name number])

;; 构造函数
; make-pet

;; 选择函数
; pet-name
; pet-number

;; 谓词
; pet?


;; Definition 4.
(define-struct CD [artist title price])

;; 构造函数
; make-CD

;; 选择函数
; CD-artist
; CD-title
; CD-price

;; 谓词
; CD?


;; Definition 5.
(define-struct sweater [material size producer])

;; 构造函数
; make-sweater

;; 选择函数
; sweater-material
; sweater-size
; sweater-producer

;; 谓词
; sweater?
