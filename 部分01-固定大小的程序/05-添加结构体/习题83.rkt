#lang racket

(require 2htdp/image)

;;; Definitions

(define-struct editor [pre post])
; Editor 是结构体
;     (make-editor String String)
; 解释: (make-editor s t) 描述了编辑器，其可见文本是(string-append s t), 光标位于 s 与 t 之间

(define EDITOR (make-editor "hello" " world"))
(define EDITOR-BACKGROUND (empty-scene 200 20))

(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 20)
(define CURSOR-COLOR "red")
(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" CURSOR-COLOR))

(define TEXT-SIZE 11)
(define TEXT-COLOR "black")

;;; Functions

; Editor -> Image
; 生成编辑器图像
(check-expect (render EDITOR) (overlay/align "left" "center"
                 (beside (draw-text "hello")
                         CURSOR
                         (draw-text " world"))
                 EDITOR-BACKGROUND))
(define (render editor)
  (overlay/align "left" "center"
                 (beside (draw-text (editor-pre editor))
                         CURSOR
                         (draw-text (editor-post editor)))
                 EDITOR-BACKGROUND))

; String -> Image
; 生成编辑器图像中的文字
(check-expect (draw-text "test") (text "test" TEXT-SIZE TEXT-COLOR))
(define (draw-text s)
  (text s TEXT-SIZE TEXT-COLOR))

;;; Application

(render EDITOR)
