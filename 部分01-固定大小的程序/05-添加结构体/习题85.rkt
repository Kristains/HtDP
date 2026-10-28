#lang racket

(require 2htdp/image)
(require 2htdp/universe)

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

; Editor -> Editor
; 启动编辑器
(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))

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

; Editor KeyEvent -> Editor
; 根据给定参数生成编辑器
(check-expect (edit EDITOR "1") (make-editor "hello1" " world"))
(check-expect (edit EDITOR "a") (make-editor "helloa" " world"))
(check-expect (edit EDITOR "\b") (make-editor "hell" " world"))
(check-expect (edit EDITOR "\t") (make-editor "hello" " world"))
(check-expect (edit EDITOR "\r") (make-editor "hello" " world"))
(check-expect (edit EDITOR "left") (make-editor "hell" "o world"))
(check-expect (edit EDITOR "right") (make-editor "hello " "world"))
(define (edit ed ke)
  (cond
    [(string=? ke "left")
     (make-editor
      (string-remove-last (editor-pre ed))
      (string-append (string-last (editor-pre ed)) (editor-post ed)))]
    [(string=? ke "right")
     (make-editor
      (string-append (editor-pre ed) (string-first (editor-post ed)))
      (string-remove-first (editor-post ed)))]
    [(string=? ke "\b")
     (make-editor
      (string-remove-last (editor-pre ed))
      (editor-post ed))]
    [(and (= (string-length ke) 1)
          (not (string=? ke "\t"))
          (not (string=? ke "\r")))
     (make-editor
      (string-append (editor-pre ed) ke)
      (editor-post ed))]
    [else ed]))

; String -> String
; 提取出字符串中第一个字符
(check-expect (string-first "str") "s")
(check-expect (string-first "s") "s")
(check-expect (string-first "") "")
(define (string-first s)
  (if (> (string-length s) 1)
      (substring s 0 1)
      s))

; String -> String
; 删除字符串中第一个字符
(check-expect (string-remove-first "str") "tr")
(check-expect (string-remove-first "s") "")
(check-expect (string-remove-first "") "")
(define (string-remove-first s)
  (if (> (string-length s) 0)
      (substring s 1)
      s))

; String -> String
; 提取出字符串中最后一个字符
(check-expect (string-last "str") "r")
(check-expect (string-last "s") "s")
(check-expect (string-last "") "")
(define (string-last s)
    (if (> (string-length s) 0)
      (substring s (- (string-length s) 1))
      s))

; String -> String
; 删除字符串中最后一个字符
(check-expect (string-remove-last "str") "st")
(check-expect (string-remove-last "s") "")
(check-expect (string-remove-last "") "")
(define (string-remove-last s)
      (if (> (string-length s) 0)
          (substring s 0 (- (string-length s) 1))
          s))
