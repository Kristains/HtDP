#lang racket

(require 2htdp/image)
(require 2htdp/universe)

; Test
(check-expect (render "red") (circle TRAFFIC-LIGHT-RADIUS "solid" "red"))
(check-expect (render "green") (circle TRAFFIC-LIGHT-RADIUS "solid" "green"))
(check-expect (render "yellow") (circle TRAFFIC-LIGHT-RADIUS "solid" "yellow"))

(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
; Define
(define TRAFFIC-LIGHT-RADIUS 10)

; WorldState -> WorldState
; 从某个初始状态启动程序
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick traffic-light-next]))

; WorldState -> Images
; 获取当前世界状态的图像
(define (render ws)
  (circle TRAFFIC-LIGHT-RADIUS "solid" ws))

; TrafficLight -> TrafficLight
; 给定当前状态 ws, 产生下一个状态
(define (traffic-light-next ws)
  (cond
    [(string=? "red" ws) "green"]
    [(string=? "green" ws) "yellow"]
    [(string=? "yellow" ws) "red"]))
