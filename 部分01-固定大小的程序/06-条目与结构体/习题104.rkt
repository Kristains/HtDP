;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题104) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Definition

; 车辆种类有
; - 汽车 (automobile)
; - 货车 (van)
; - 公交汽车 (bus)
; - SUV

(define-struct vehicle [type carry-num license fuel-consumption])
; (make-automobile String Number String Number)
; (make-automobile t c l f)
; 汽车的类型
; 汽车的可载人数(carry-num)
; 车牌号码(license)
; 燃油消耗(每升公里数)(fuel-consumption)

;; Function

; 函数开发模板
(define (vehicle-consumer v)
  (... (vehicle-type v) ...
       (vehicle-carry-num v) ...
       (vehicle-license v) ...
       (vehicle-fuel-consumption v) ...))
