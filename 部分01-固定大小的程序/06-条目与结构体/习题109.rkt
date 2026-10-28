;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题109) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; Definition

(define SCENE-WIDTH 150)
(define SCENE-HEIGHT 150)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define WHITE-SQU (square 100 "solid" "white"))
(define YELLOW-SQU (square 100 "solid" "yellow"))
(define GREEN-SQU (square 100 "solid" "green"))
(define RED-SQU (square 100 "solid" "red"))

; ExpectsToSee.v2 是下列之一:
; – AA
; – BB
; – DD
; – ER

(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

;; FUNCTION

; 主程序
(define (main s)
  (big-bang s
    [to-draw render]
    [on-key key-handler]))

; State -> Image
; 显示图案
(check-expect (render AA) (overlay WHITE-SQU SCENE))
(check-expect (render BB) (overlay YELLOW-SQU SCENE))
(check-expect (render DD) (overlay GREEN-SQU SCENE))
(check-expect (render ER) (overlay RED-SQU SCENE))
(define (render s)
  (overlay (state-render s)
           SCENE))

; State -> Image
; 显示不同颜色矩阵
(check-expect (state-render AA) WHITE-SQU)
(check-expect (state-render BB) YELLOW-SQU)
(check-expect (state-render DD) GREEN-SQU)
(check-expect (state-render ER) RED-SQU)
(define (state-render s)
  (cond
    [(string=? s AA) WHITE-SQU]
    [(string=? s BB) YELLOW-SQU]
    [(string=? s DD) GREEN-SQU]
    [(string=? s ER) RED-SQU]))

; State KeyEvent -> State
; 根据按键更改状态
(check-expect (key-handler AA "a") BB)
(check-expect (key-handler AA "b") ER)
(check-expect (key-handler AA "c") ER)
(check-expect (key-handler AA "d") ER)
(check-expect (key-handler AA "e") ER)
(check-expect (key-handler BB "a") ER)
(check-expect (key-handler BB "b") BB)
(check-expect (key-handler BB "c") BB)
(check-expect (key-handler BB "d") DD)
(check-expect (key-handler BB "e") ER)
(check-expect (key-handler DD "a") DD)
(check-expect (key-handler DD "b") DD)
(check-expect (key-handler DD "c") DD)
(check-expect (key-handler DD "d") DD)
(check-expect (key-handler DD "e") DD)
(check-expect (key-handler ER "a") ER)
(check-expect (key-handler ER "b") ER)
(check-expect (key-handler ER "c") ER)
(check-expect (key-handler ER "d") ER)
(check-expect (key-handler ER "e") ER)
(define (key-handler s k)
  (cond
    [(string=? s AA) (cond
                       [(key=? k "a") BB]
                       [else ER])]
    [(string=? s BB) (cond
                       [(key=? k "b") BB]
                       [(key=? k "c") BB]
                       [(key=? k "d") DD]
                       [else ER])]
    [else s]))
