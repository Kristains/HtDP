;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题135) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-names -> Boolean
; 判断"Flatt"是否在 alon 中
(check-expect
 (contains-flatt? (cons "X" (cons "Y" (cons "Z" '()))))
 #false)
(check-expect
 (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
 #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

(contains-flatt? (cons "Flatt" (cons "C" '())))
;->
(cond
 ((empty? (cons "Flatt" (cons "C" '()))) #false)
 ((cons? (cons "Flatt" (cons "C" '())))
  (or (string=? (first (cons "Flatt" (cons "C" '())))
                "Flatt")
      (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))))
;->
(cond
 (#false #false)
 ((cons? (cons "Flatt" (cons "C" '())))
  (or (string=? (first (cons "Flatt" (cons "C" '())))
                "Flatt")
      (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))))
;->
(cond
 ((cons? (cons "Flatt" (cons "C" '())))
  (or (string=? (first (cons "Flatt" (cons "C" '())))
                "Flatt")
      (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))))
;->
(cond
 (#true
  (or (string=? (first (cons "Flatt" (cons "C" '())))
                "Flatt")
      (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))))
;->
(or (string=? (first (cons "Flatt" (cons "C" '())))
              "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
;->
(or (string=? "Flatt" "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
;->
(or #true
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
;->
#true
