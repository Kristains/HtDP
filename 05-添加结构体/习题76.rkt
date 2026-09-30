#lang racket

(define-struct movie [title producer year])
;; Movie 是一个结构体:
;; (make-movie String String Number)
;; (make-movie t p y) 表示一部电影
;; 其中标题 (title) 为 t
;; 出品人 (producer) 为 p
;; 上映于年份 (year) y

(define-struct person [name hair eyes phone])
;; Person 是一个结构体:
;; (make-person String String String String)
;; (make-person n h e p) 表示一个人
;; 其中姓名 (name) 为 n
;; 发型 (hair) 为 h
;; 眼睛 (eyes) 为 e
;; 手机 (phone) 为 p

(define-struct pet [name number])
;; Pet 是一个结构体:
;; (make-pet String Number)
;; (make-pet n num) 表示一只宠物
;; 其中姓名 (name) 为 n
;; 宠物 id (number) 为 num

(define-struct CD [artist title price])
;; CD 是一个结构体:
;; (make-CD String String Number)
;; (make-CD a t p) 表示一张光盘
;; 其中艺术家 (artist) 为 a
;; 标题 (title) 为 t
;; 价格 (price) 为 p

(define-struct sweater [material size priducer])
;; Sweater 是一个结构体:
;; (make-sweater sweater String String String)
;; (make-sweater m s p) 表示一件毛衣
;; 其中材质 (material) 为 m
;; 尺寸 (size) 为 s
;; 出品方 (priducer) 为 p
