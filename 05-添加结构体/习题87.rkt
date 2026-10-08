#lang racket

(requirt 2htdp/image)
(requirt 2htdp/universe)

;;; Definitions

(define-struct editor [context cursor-at])
; Editor 是 (make-editor String Index)
; 字符串 content 是可见的全部文本,索引 cursor-at 表示光标的位置(在 content 的第几个字符之前)
; 比如 (make-editor "hello world" 5) 表示文本是 "hello world",光标在 h e l l o | ␣ w o r l d 的位置。

(define EDITOR (make-editor "hello world" 5))
(define EDITOR_0 (make-editor "hello world" 0))
(define EDITOR_END (make-editor "hello world" 11))
(define EDITOR-EMPTY (make-editor "" 0))

(define EDITOR-BACKGROUND-WIDTH 200)
(define EDITOR-BACKGROUND-HEIGHT 20)
(define EDITOR-BACKGROUND (empty-scene EDITOR-BACKGROUND-WIDTH EDITOR-BACKGROUND-HEIGHT))

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
(define (render ed)
  (overlay/align "left" "center"
                 (beside (draw-text (substring (editor-context ed) 0 (editor-cursor-at ed)))
                         CURSOR
                         (draw-text (substring (editor-context ed) (editor-cursor-at ed))))
                 EDITOR-BACKGROUND))

; String -> Image
; 生成编辑器图像中的文字
(check-expect (draw-text "test") (text "test" TEXT-SIZE TEXT-COLOR))
(define (draw-text s)
  (text s TEXT-SIZE TEXT-COLOR))

; Editor KeyEvent -> Editor
; 根据给定参数生成编辑器
(check-expect (edit EDITOR "1") (make-editor "hello1 world" 6))
(check-expect (edit EDITOR "a") (make-editor "helloa world" 6))
(check-expect (edit EDITOR "\b") (make-editor "hell world" 4))
(check-expect (edit EDITOR "\t") (make-editor "hello world" 5))
(check-expect (edit EDITOR "\r") (make-editor "hello world" 5))
(check-expect (edit EDITOR "left") (make-editor "hello world" 4))
(check-expect (edit EDITOR "right") (make-editor "hello world" 6))
(check-expect (edit (make-editor (make-string 200 #\a) 5) "a") (make-editor (make-string 200 #\a) 5))
(check-expect (edit EDITOR_0 "a") (make-editor "ahello world" 1))
(check-expect (edit EDITOR_0 "\b") (make-editor "hello world" 0))
(check-expect (edit EDITOR_0 "left") (make-editor "hello world" 0))
(check-expect (edit EDITOR_0 "right") (make-editor "hello world" 1))
(check-expect (edit EDITOR_END "a") (make-editor "hello worlda" 12))
(check-expect (edit EDITOR_END "\b") (make-editor "hello worl" 10))
(check-expect (edit EDITOR_END "left") (make-editor "hello world" 10))
(check-expect (edit EDITOR_END "right") (make-editor "hello world" 11))
(check-expect (edit EDITOR-EMPTY "a") (make-editor "a" 1))
(check-expect (edit EDITOR-EMPTY "\b") (make-editor "" 0))
(check-expect (edit EDITOR-EMPTY "left") (make-editor "" 0))
(check-expect (edit EDITOR-EMPTY "right") (make-editor "" 0))
(define (edit ed ke)
  (cond
    [(string=? ke "left")
     (make-editor
      (editor-context ed)
      (index-1 ed))]
    [(string=? ke "right")
     (make-editor
      (editor-context ed)
      (index+1 ed))]
    [(string=? ke "\b")
     (make-editor
      (context-delete ed)
      (index-1 ed))]
    [(insert? ed ke)
     (make-editor
      (context-insert ed ke)
      (+ (editor-cursor-at ed) 1))]
    [else ed]))

; Editor -> Number
; 将光标的位置减 1
(check-expect (index-1 EDITOR) 4)
(check-expect (index-1 EDITOR_0) 0)
(check-expect (index-1 EDITOR_END) 10)
(define (index-1 ed)
  (if (> (editor-cursor-at ed) 0)
      (- (editor-cursor-at ed) 1)
      0))

; Editor -> Number
; 将光标的位置加 1
(check-expect (index+1 EDITOR) 6)
(check-expect (index+1 EDITOR_0) 1)
(check-expect (index+1 EDITOR_END) 11)
(define (index+1 ed)
  (if (< (editor-cursor-at ed) (string-length (editor-context ed)))
      (+ (editor-cursor-at ed) 1)
      (editor-cursor-at ed)))

; Editor -> String
; 删除光标之前一个位置的字符
(check-expect (context-delete EDITOR) "hell world")
(check-expect (context-delete EDITOR_0) "hello world")
(check-expect (context-delete EDITOR_END) "hello worl")
(define (context-delete ed)
  (string-append (substring (editor-context ed) 0 (index-1 ed))
                 (substring (editor-context ed) (editor-cursor-at ed))))

; Editor KeyEvent -> String
; 光标之前的位置添加一个字符
(check-expect (context-insert EDITOR "1") "hello1 world")
(check-expect (context-insert EDITOR "a") "helloa world")
(check-expect (context-insert EDITOR_0 "a") "ahello world")
(check-expect (context-insert EDITOR_END "a") "hello worlda")
(define (context-insert ed ke)
      (string-append (substring (editor-context ed) 0 (editor-cursor-at ed))
                     ke
                     (substring (editor-context ed) (editor-cursor-at ed))))

; Editor KeyEvent -> Boolean
; 判断是否将字符输入进编辑器内
(check-expect (insert? EDITOR "1") #true)
(check-expect (insert? EDITOR "a") #true)
(check-expect (insert? EDITOR "\t") #false)
(check-expect (insert? EDITOR "\r") #false)
(check-expect (insert? (make-editor (make-string 200 #\a) 0) "a") #false)
(define (insert? ed ke)
  (and (= (string-length ke) 1)
          (not (string=? ke "\t"))
          (not (string=? ke "\r"))
          (< (image-width (draw-text (editor-context ed)))
             (- EDITOR-BACKGROUND-WIDTH TEXT-SIZE))))
