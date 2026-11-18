;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题129) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; 天体的链表，至少包含太阳系中所有的行星
(cons "Neptune"
      (cons "Uranus"
            (cons "Saturn"
                  (cons "Jupiter"
                        (cons "Mars"
                              (cons "Earth"
                                    (cons "Venus"
                                          (cons "Mercury"
                                                '()))))))))

;; 用餐的清单
(cons "steak"
      (cons "chips"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "cheese"
                                    (cons "ice-cream"
                                          '())))))))

;; 颜色的链表
(cons "red"
      (cons "green"
            (cons "blue"
                  '())))