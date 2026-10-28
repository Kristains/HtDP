#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 相比于 59 题的代码，将字符串改为数字并不能更好的传达其意图
;; 因为“red”，“yellow”，“green”这一类字符串本身就自带意义
;; 0,1,2 这些数字就需要查看注释，增加了额外记忆负担

;; 测试函数
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

(check-expect (tl-render 0)
              (place-image REDLIGHT-ON X-LIGHT-RED Y-LIGHT
               (place-image YELLOWLIGHT X-LIGHT-YELLOW Y-LIGHT
                (place-image GREENLIGHT X-LIGHT-GREEN Y-LIGHT
                 BACKGROUND))))
(check-expect (tl-render 1)
              (place-image REDLIGHT X-LIGHT-RED Y-LIGHT
               (place-image YELLOWLIGHT-ON X-LIGHT-YELLOW Y-LIGHT
                (place-image GREENLIGHT X-LIGHT-GREEN Y-LIGHT
                 BACKGROUND))))
(check-expect (tl-render 2)
              (place-image REDLIGHT X-LIGHT-RED Y-LIGHT
               (place-image YELLOWLIGHT X-LIGHT-YELLOW Y-LIGHT
                (place-image GREENLIGHT-ON X-LIGHT-GREEN Y-LIGHT
                 BACKGROUND))))

(check-expect (which-light-on 0 0 REDLIGHT-ON    REDLIGHT)    REDLIGHT-ON)
(check-expect (which-light-on 0 1 YELLOWLIGHT-ON YELLOWLIGHT) YELLOWLIGHT)

;; 定义区
; N-TrafficLight 是下列之一：
; -- 0 解释:交通灯显示红色
; -- 1 解释:交通灯显示黄色
; -- 2 解释:交通灯显示绿色

(define BACKGROUND (empty-scene 90 30))
(define Y-LIGHT 15)

; 红灯
(define REDLIGHT    (circle 10 "outline" "red"))
(define REDLIGHT-ON (circle 10 "solid"   "red"))
(define X-LIGHT-RED 15)

; 黄灯
(define YELLOWLIGHT    (circle 10 "outline" "yellow"))
(define YELLOWLIGHT-ON (circle 10 "solid"   "yellow"))
(define X-LIGHT-YELLOW 45)

; 绿灯
(define GREENLIGHT    (circle 10 "outline" "green"))
(define GREENLIGHT-ON (circle 10 "solid"   "green"))
(define X-LIGHT-GREEN 75)

;; TrafficLight -> TrafficLight
;; 给定当前状态为 cs,返回下一个状态
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

;; String String Image Image -> Image
;; 若 current-status 等于灯的颜色名,则返回亮灯图,否则返回灭灯图
(define (which-light-on current-status color-name light-on light-off)
  (if (= current-status color-name)
      light-on
      light-off))

;; TrafficLight -> Image
;; 将当前状态 cs 呈现为图像
(define (tl-render current-status)
  (place-image
   (which-light-on current-status 0 REDLIGHT-ON REDLIGHT) X-LIGHT-RED Y-LIGHT
   (place-image
    (which-light-on current-status 1 YELLOWLIGHT-ON YELLOWLIGHT) X-LIGHT-YELLOW Y-LIGHT
    (place-image
     (which-light-on current-status 2 GREENLIGHT-ON GREENLIGHT) X-LIGHT-GREEN Y-LIGHT
     BACKGROUND))))

;; TrafficLight -> TrafficLight
;; 模拟基于时钟的交通灯
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-numeric 1]))
