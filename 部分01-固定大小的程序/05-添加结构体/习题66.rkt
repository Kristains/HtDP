#lang racket

(define-struct movie [title producer year])

;; 构造函数
(define m (make-movie "Some Title" "THE Producer" 2020))

;; 选择函数
(movie-title m)
(movie-producer m)
(movie-year m)

;; 谓词
(movie? m)


;; Definition 2.
(define-struct person [name hair eyes phone])

;; 构造函数
(define p1 (make-person "Alan Turing" "Brown" "Blue" "21-910-532"))

;; 选择函数
(person-name p1)
(person-hair p1)
(person-eyes p1)
(person-phone p1)

;; 谓词
(person? p1)


;; Definition 3.
(define-struct pet [name number])

;; 构造函数
(define p2 (make-pet "BumbleBee" 33))

;; 选择函数
(pet-name p2)
(pet-number p2)

;; 谓词
(pet? p2)

;; Definition 4.
(define-struct CD [artist title price])

;; 构造函数
(define c (make-CD "Maya P." "Dancing" 33.5))

;; 选择函数
(CD-artist c)
(CD-title c)
(CD-price c)

;; 谓词
(CD? c)


;; Definition 5.
(define-struct sweater [material size producer])

;; 构造函数
(define s (make-sweater "Wool" 42 "ZaphodB"))

;; 选择函数
(sweater-material s)
(sweater-size s)
(sweater-producer s)

;; 谓词
(sweater? s)
