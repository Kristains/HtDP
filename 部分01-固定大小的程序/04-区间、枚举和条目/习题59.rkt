#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;; 测试函数
(check-expect (tl-next "red")    "yellow")
(check-expect (tl-next "yellow") "green")
(check-expect (tl-next "green")  "red")

(check-expect (tl-render "red")
              (place-image REDLIGHT-ON X-LIGHT-RED Y-LIGHT
               (place-image YELLOWLIGHT X-LIGHT-YELLOW Y-LIGHT
                (place-image GREENLIGHT X-LIGHT-GREEN Y-LIGHT
                 BACKGROUND))))
(check-expect (tl-render "yellow")
              (place-image REDLIGHT X-LIGHT-RED Y-LIGHT
               (place-image YELLOWLIGHT-ON X-LIGHT-YELLOW Y-LIGHT
                (place-image GREENLIGHT X-LIGHT-GREEN Y-LIGHT
                 BACKGROUND))))
(check-expect (tl-render "green")
              (place-image REDLIGHT X-LIGHT-RED Y-LIGHT
               (place-image YELLOWLIGHT X-LIGHT-YELLOW Y-LIGHT
                (place-image GREENLIGHT-ON X-LIGHT-GREEN Y-LIGHT
                 BACKGROUND))))

(check-expect (which-light-on "red" "red"    REDLIGHT-ON REDLIGHT)       REDLIGHT-ON)
(check-expect (which-light-on "red" "yellow" YELLOWLIGHT-ON YELLOWLIGHT) YELLOWLIGHT)

;; 定义区
(define BACKGROUND (empty-scene 90 30))
(define Y-LIGHT 15)

;; 红灯
(define REDLIGHT    (circle 10 "outline" "red"))
(define REDLIGHT-ON (circle 10 "solid"   "red"))
(define X-LIGHT-RED 15)

;; 黄灯
(define YELLOWLIGHT    (circle 10 "outline" "yellow"))
(define YELLOWLIGHT-ON (circle 10 "solid"   "yellow"))
(define X-LIGHT-YELLOW 45)

;; 绿灯
(define GREENLIGHT    (circle 10 "outline" "green"))
(define GREENLIGHT-ON (circle 10 "solid"   "green"))
(define X-LIGHT-GREEN 75)

;; TrafficLight -> TrafficLight
;; 给定当前状态为 cs,返回下一个状态
(define (tl-next cs)
  (cond
    [(string=? "red"    cs) "yellow"]
    [(string=? "yellow" cs) "green" ]
    [(string=? "green"  cs) "red"   ]))

;; String String Image Image -> Image
;; 若 current-status 等于灯的颜色名,则返回亮灯图,否则返回灭灯图
(define (which-light-on current-status color-name light-on light-off)
  (if (string=? current-status color-name)
      light-on
      light-off))

;; TrafficLight -> Image
;; 将当前状态 cs 呈现为图像
(define (tl-render current-status)
  (place-image
   (which-light-on current-status "red" REDLIGHT-ON REDLIGHT) X-LIGHT-RED Y-LIGHT
   (place-image
    (which-light-on current-status "yellow" YELLOWLIGHT-ON YELLOWLIGHT) X-LIGHT-YELLOW Y-LIGHT
    (place-image
     (which-light-on current-status "green" GREENLIGHT-ON GREENLIGHT) X-LIGHT-GREEN Y-LIGHT
     BACKGROUND))))

;; TrafficLight -> TrafficLight
;; 模拟基于时钟的交通灯
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))
