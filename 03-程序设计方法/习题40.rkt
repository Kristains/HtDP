#lang racket

; WorldState -> WorldState
; 时钟每滴答 1 次,移动汽车 3 个像素
; 示例:
;   输入 20,期待输出 23
;   输入 78,期待输出 81
(define (tock ws)
  (+ ws 3))

; 测试函数
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
