;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题125) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct oops [])
; 合法
; 匹配 (define-struct name)
; 字段列表可以为空

(define-struct child [parents dob date])
; 合法
; 匹配 (define-struct name [name name name])

(define-struct (child person) [dob date])
; 非法
; (child person) 这部分必须是一个 name
; 这里是两个 name
