;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题103) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Definition

; 动物园的动物有
; - 蜘蛛 (spider)
; - 大象 (elephant)
; - 蟒蛇 (boa constrictor)
; - 犰狳 (armadillo)

(define-struct spider [legs space])
; (make-spider Number Number)
; 蜘蛛有腿(legs)与体积(space)

(define-struct elephant [space])
; (make-elephant Number)
; 大象有体积(space)

(define-struct boa [length girth])
; (make-elephant Number Number)
; 蟒蛇有身长(length)与围长(girth)

(define-struct armadillo [space])
; (make-elephant Number)
; 犰狳有体积(space)

;; Function

; 函数开发模板
(define (zoo-animal a)
  (cond
    [(spider? a) ... (spider-legs a) ... (spider-space a) ...]
    [(elephant? a) ... (elephant-space a) ...]
    [(boa? a) ... (spider-length a) ... (spider-girth a) ...]
    [(armadillo? a) ... (armadillo-space a) ...]))

; fit? : SIGS Number -> Boolean
; 判断笼子的体积是否能够装下动物
(define (fit? s cage-space)
  (cond
    [(spider? s) (> cage-space (spider-space s))]
    [(elephant? s) (> cage-space (elephant-space s))]
    [(boa? s) (> cage-space (* (spider-length s) (spider-girth s)))]
    [(armadillo? s) (> cage-space (armadillo-space s))]))