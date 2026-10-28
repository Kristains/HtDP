;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题113) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; (make-posn x y) 表示 UFO 的位置

(define-struct tank [loc vel])
; (make-tank Number Number)
; 坦克的位置(loc, TANK-Y), 坦克移动的速度 vel 个像素

; (make-posn x y) 表示导弹(missile)的位置

; SIGS
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; (make-aim UFO Tank)
; (make-fired UFO Tank Missile)
; 表示空间入侵者游戏的完整状态


;; Any -> Boolean
;; 检查是否为 SIGS 集合的元素
(check-expect (sigs? (make-aim
                      (make-posn 10 20)
                      (make-tank 28 -3)))
              #true)
(check-expect (sigs? (make-fired
                      (make-posn 20 100)
                      (make-tank 100 3)
                      (make-posn 22 103)))
              #true)
(check-expect (sigs? (make-posn 20 100)) #false)
(define (sigs? s)
  (or (aim? s) (fired? s)))

;; Definitions

; 一个坐标(Coordinate)有:
; – 负数
; 在 y 轴上,到上边(顶部)的距离
; – 正数
; 在 x 轴上,到左边的距离
; – Posn
; 一个笛卡尔点

;; Any -> Boolean
;; 检查是否为 coordinate 集合的元素
(check-expect (coordinate? -10) #true)
(check-expect (coordinate? -20) #true)
(check-expect (coordinate? 10) #true)
(check-expect (coordinate? 20) #true)
(check-expect (coordinate? (make-posn 10 -10)) #true)
(check-expect (coordinate? (make-posn 20 -20)) #true)
(check-expect (coordinate? 0) #false)
(check-expect (coordinate? "a") #false)
(define (coordinate? c)
  (or (and (number? c)
           (not (= c 0)))
      (posn? c)))

; VAnimal 是以下之一:
; - VCat
; - VCham

(define-struct VCat [pos-x happy])
;; (make-VCat Number Number)
;; pos-x 记录猫的横坐标, happy 记录猫的快乐指数

(define-struct VCham [color pos-x happy])
;; (make-VCat Color Number Number)
;; color 记录变色龙的颜色, pos-x 记录变色龙的横坐标, happy-num 记录变色龙的快乐指数

(define RED "red")
(define GREEN "green")
(define BLUE "blue")
;; Color 是以下之一:
;; - RED
;; - GREEN
;; - BLUE

;; Any -> Boolean
;; 检查是否为 vanimal 集合的元素
(check-expect (vanimal? (make-VCat 20 100)) #true)
(check-expect (vanimal? (make-VCham RED 30 100)) #true)
(check-expect (vanimal? (make-posn 20 100)) #false)
(check-expect (vanimal? "a") #false)
(define (vanimal? v)
  (or (VCat? v) (VCham? v)))
