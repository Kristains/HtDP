;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题128) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(check-member-of "green" "red" "yellow" "grey")
; 实际值"green"不同与所有给定的 "red" "yellow" "grey"

(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)  0.01)
; 实际值(make-posn #i1.0 #i1.1)不在期望值(make-posn #i0.9 #i1.2)的0.01范围内

(check-range #i0.9 #i0.6 #i0.8)
; 实际值#i0.9不在#i0.6和#i0.8之间（包含）

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))
; 数据范围不一致

(check-satisfied 4 odd?)
; 4 不是奇数
