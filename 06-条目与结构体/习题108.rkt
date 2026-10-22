;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题108) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; Definition

(define-struct Light [state timer])
; (make-Light State Number)
; 灯的状态(state)与倒计时(timer)

; State 有下列之一: "stand" "walk"
(define STAND "stand")
(define WALK "walk")

(define STOP-PIC .)
(define WALK-PIC .)

(define SCENE-STATE-WIDTH (* 1.5 (image-width STOP-PIC)))
(define SCENE-STATE-HEIGHT (* 1.5 (image-height STOP-PIC)))
(define SCENE-STATE (rectangle SCENE-STATE-WIDTH SCENE-STATE-HEIGHT "solid" "black"))
(define SCENE-TIMER-WIDTH (* 1.5 (image-width STOP-PIC)))
(define SCENE-TIMER-HEIGHT (* 0.5 (image-height STOP-PIC)))
(define SCENE-TIMER (rectangle SCENE-TIMER-WIDTH SCENE-TIMER-HEIGHT "solid" "black"))

(define TEXT-SIZE 30)
;数字的颜色有下列之一: "orange" "green"
(define ORANGE "orange")
(define GREEN "green")

(define TEXT-STAND (make-Light STAND 0))
(define TEXT-WALK (make-Light WALK 10))

;; Function

(define (main l)
  (big-bang l
    [to-draw render]
    [on-tick tick-handler 1]
    [on-key key-handler]))

; Light -> Image
; 显示运行图案
(check-expect (render TEXT-STAND) (above (overlay STOP-PIC SCENE-STATE)
                                         SCENE-TIMER))
(check-expect (render TEXT-WALK) (above (overlay WALK-PIC SCENE-STATE)
                                        (overlay (text "10" TEXT-SIZE GREEN) SCENE-TIMER)))
(define (render l)
  (cond
    [(string=? (Light-state l) STAND) (above (state-render (Light-state l))
                                             SCENE-TIMER)]
    [(string=? (Light-state l) WALK) (above (state-render (Light-state l))
                                            (text-render (Light-timer l)))]))

; STATE -> Image
; 显示状态图案
(check-expect (state-render STAND) (overlay STOP-PIC SCENE-STATE))
(check-expect (state-render WALK) (overlay WALK-PIC SCENE-STATE))
(define (state-render s)
  (overlay (if (string=? s STAND) STOP-PIC WALK-PIC) SCENE-STATE))

; Number -> Image
; 显示倒计时图案
(check-expect (text-render 10) (overlay (text "10" TEXT-SIZE GREEN) SCENE-TIMER))
(check-expect (text-render 9) (overlay (text "9" TEXT-SIZE ORANGE) SCENE-TIMER))
(define (text-render t)
  (overlay (text (number->string t) TEXT-SIZE (text-color t)) SCENE-TIMER))

; Number -> COLOR
; 显示文本颜色
(check-expect (text-color 10) GREEN)
(check-expect (text-color 9) ORANGE)
(define (text-color t)
  (if (odd? t) ORANGE GREEN))

; Light -> Light
; 更新数据状态
(check-expect (tick-handler TEXT-STAND) TEXT-STAND)
(check-expect (tick-handler TEXT-WALK) (make-Light WALK 9))
(check-expect (tick-handler (make-Light WALK 1)) (make-Light STAND 0))
(define (tick-handler l)
  (cond
    [(string=? (Light-state l) STAND) l]
    [(string=? (Light-state l) WALK) (if (> (Light-timer l) 1)
                               (make-Light WALK (- (Light-timer l) 1))
                               (make-Light STAND 0))]))

; Light KeyEvent -> Light
; 通过按键来更新数据状态
; 按键有下列之一：
; " ": 由 STAND 改为 WALK，此时的 timer 为 10
(define (key-handler l key)
  (if (and (string=? (Light-state l) STAND)
           (key=? key " "))
      (make-Light WALK 10)
      l))
