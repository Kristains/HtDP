;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题106) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Definition

(define SCENE-WIDTH 400)
(define SCENE-HEIGHT 300)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

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

;; KeyEvent 是以下之一:
;; - "up"
;; - "down"
;; - "r"
;; - "b"
;; - "g"
;; 表示一个被按下的按键,该按键会触发某个操作
;; 改变世界状态

(define CAT1 (bitmap ./images/cat1.png))
(define CAT2 (bitmap ./images/cat2.png))
(define CAT3 (bitmap ./images/cat3.png))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CAT-Y (- SCENE-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-SPEED 3)

(define CHAM1 (bitmap ./images/cham1.png))
(define CHAM2 (bitmap ./images/cham2.png))
(define CHAM-WIDTH (image-width CHAM1))
(define CHAM-HEIGHT (image-height CHAM1))
(define CHAM-Y (- SCENE-HEIGHT (/ CHAM-HEIGHT 2) 1))
(define CHAM-SPEED 3)

(define STEP 12)

(define HAPPY-MAX_HEIGHT 100)
(define HAPPY-WIDTH 30)
(define HAPPY-X 35)
(define HAPPY-Y 80)
(define HAPPY-STATUS_COLOR "red")
(define HAPPY-BACKGROUND_COLOR "orange")
(define HAPPY-SPEED 0.1)
(define HAPPY-INCREASE_DOWN 3)
(define HAPPY-INCREASE_UP 5)

(define VCAT-START (make-VCat (/ CAT-WIDTH 2) 100))
(define VCHAM-START (make-VCham RED (/ CHAM-WIDTH 2) 100))

;; Function

;; VAnimal -> NUmber
;; 获取动物的横坐标
(check-expect (animal-pos-x (make-VCat 20 100)) 20)
(check-expect (animal-pos-x (make-VCham RED 30 100)) 30)
(define (animal-pos-x va)
  (cond
    [(VCat? va) (VCat-pos-x va)]
    [(VCham? va) (VCham-pos-x va)]))

;; VAnimal -> NUmber
;; 获取动物的能达到的最大横坐标
(define (animal-pos-x-max va)
  (cond
    [(VCat? va) (round
                 (+ SCENE-WIDTH (/ CAT-WIDTH 2)))]
    [(VCham? va) (round
                  (+ SCENE-WIDTH (/ CHAM-WIDTH 2)))]))

;; VAnimal -> NUmber
;; 获取动物的纵坐标
(check-expect (animal-pos-y (make-VCat 20 100)) CAT-Y)
(check-expect (animal-pos-y (make-VCham RED 30 100)) CHAM-Y)
(define (animal-pos-y va)
  (cond
    [(VCat? va) CAT-Y]
    [(VCham? va) CHAM-Y]))

;; VAnimal -> Number
;; 获取动物的速度
(check-expect (animal-speed (make-VCat 20 100)) CAT-SPEED)
(check-expect (animal-speed (make-VCham RED 30 100)) CHAM-SPEED)
(define (animal-speed va)
  (cond
    [(VCat? va) CAT-SPEED]
    [(VCham? va) CHAM-SPEED]))

;; VAnimal -> Number
;; 获取动物的快乐指数
(check-expect (animal-happy (make-VCat 20 80)) 80)
(check-expect (animal-happy (make-VCham RED 30 90)) 90)
(define (animal-happy va)
  (cond
    [(VCat? va) (VCat-happy va)]
    [(VCham? va) (VCham-happy va)]))

;; 主程序
(define (cat-cham animal)
  (big-bang animal
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    [check-with vanimal?] ; 添加 114 题解答
    [stop-when end?]))

; VAnimal -> Image
; 获取当前世界状态的图像
(check-expect (render VCAT-START)
              (place-image CAT1 (/ CAT-WIDTH 2) CAT-Y
                           (place-image (overlay/align "middle" "bottom"
                                                       (rectangle HAPPY-WIDTH 100 "solid" HAPPY-STATUS_COLOR)
                                                       (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR))
                                        HAPPY-X HAPPY-Y
                                        SCENE)))
(check-expect (render VCHAM-START)
              (place-image (overlay
                            (animal-step-image VCHAM-START)
                            (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" RED))
                           (/ CHAM-WIDTH 2) CHAM-Y
                           (place-image (overlay/align "middle" "bottom"
                                                       (rectangle HAPPY-WIDTH 100 "solid" HAPPY-STATUS_COLOR)
                                                       (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR))
                                        HAPPY-X HAPPY-Y
                                        SCENE)))
(define (render va)
  (animal-render va
                (happy-render va SCENE)))

; VAnimal Image -> Image
; 显示动物层的图像
(check-expect (animal-render VCAT-START SCENE)
              (place-image CAT1 (/ CAT-WIDTH 2) CAT-Y SCENE))
(check-expect (animal-render VCHAM-START SCENE)
              (place-image (overlay
                            (animal-step-image VCHAM-START)
                            (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" RED))
                           (/ CHAM-WIDTH 2) CHAM-Y SCENE))
(define (animal-render va im)
  (place-image
   (animal-image va)
   (animal-pos-x va)
   (animal-pos-y va)
   im))

; VAnimal -> Image
; 显示动物的图像
(check-expect (animal-image VCAT-START) CAT1)
(check-expect (animal-image VCHAM-START) (overlay
                                          (animal-step-image VCHAM-START)
                                          (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" RED)))
(define (animal-image va)
  (cond
    [(VCat? va)
      (animal-step-image va)]
    [(VCham? va)
      (overlay
       (animal-step-image va)
       (color-cham (VCham-color va)))]))

;; VAnimal -> Image
;; 根据动物当前位置决定用哪张图
(define (animal-step-image animal)
  (step-image (animal-step (animal-pos-x animal) STEP) animal))

;; Number VAnimal -> Image
;; 给定帧号和动物,返回对应图片
(define (step-image step animal)
  (cond
    [(or (= step 0) (= step 2))
     (if (VCat? animal) CAT1 CHAM1)]
    [(= step 1)
     (if (VCat? animal) CAT2 CHAM2)]
    [(= step 3)
     (if (VCat? animal) CAT3 CHAM2)]))

;; Number Number -> Number
;; 用给定的 x 坐标和一帧的长度计算当前动画帧号(0/1/2/3 循环)
(check-expect (animal-step 0 12) 0)
(check-expect (animal-step 4 12) 0)
(check-expect (animal-step 12 12) 1)
(check-expect (animal-step 24 12) 2)
(check-expect (animal-step 36 12) 3)
(check-expect (animal-step 48 12) 0)
(check-expect (animal-step 120 12) 2)
(define (animal-step x step)
  (modulo (round (/ x step)) 4))

; COLOR -> Image
; 展示不同颜色的变色龙图像
(check-expect (color-cham RED)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" RED))
(check-expect (color-cham GREEN)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" GREEN))
(check-expect (color-cham BLUE)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" BLUE))
(define (color-cham color)
  (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" color))



; VAnimal Image -> Image
; 获取动物的快乐指数的图像
(check-expect (happy-render VCAT-START SCENE)
              (place-image (overlay/align "middle" "bottom"
                                          (rectangle HAPPY-WIDTH (VCat-happy VCAT-START) "solid" HAPPY-STATUS_COLOR)
                                          (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR))
                           HAPPY-X HAPPY-Y
                           SCENE))
(define (happy-render va im)
  (place-image (overlay/align "middle" "bottom"
                              (rectangle HAPPY-WIDTH (animal-happy va) "solid" HAPPY-STATUS_COLOR)
                              (rectangle HAPPY-WIDTH HAPPY-MAX_HEIGHT "solid" HAPPY-BACKGROUND_COLOR))
                HAPPY-X HAPPY-Y
                SCENE))

; VAnimal -> VAnimal
; 时钟每滴答一下,big-bang 从(tick-handler va)
; 获取动物的下一个状态
(check-expect (tick-handler (make-VCat 0 101)) (make-VCat CAT-SPEED 100))
(check-expect (tick-handler (make-VCat 0 0)) (make-VCat CAT-SPEED 0))
(check-expect (tick-handler (make-VCat 0 10)) (make-VCat CAT-SPEED (- 10 HAPPY-SPEED)))
(check-expect (tick-handler (make-VCat 50 20)) (make-VCat (+ 50 CAT-SPEED) (- 20 HAPPY-SPEED)))
(check-expect (tick-handler (make-VCham RED 0 101)) (make-VCham RED CHAM-SPEED 100))
(check-expect (tick-handler (make-VCham GREEN 0 0)) (make-VCham GREEN CHAM-SPEED 0))
(check-expect (tick-handler (make-VCham BLUE 0 10)) (make-VCham BLUE CHAM-SPEED (- 10 HAPPY-SPEED)))
(check-expect (tick-handler (make-VCham RED 50 20)) (make-VCham RED (+ 50 CHAM-SPEED) (- 20 HAPPY-SPEED)))
(define (tick-handler va)
  (cond
    [(VCat? va) (make-VCat
                 (update-animal-pos-x va)
                 (update-happy va))]
    [(VCham? va) (make-VCham (VCham-color va)
                             (update-animal-pos-x va)
                             (update-happy va))]))


; VAnimal -> Number
; 更新当前动物的位置
(check-expect (update-animal-pos-x VCAT-START)
              (round (+ (VCat-pos-x VCAT-START) CAT-SPEED)))
(check-expect (update-animal-pos-x VCHAM-START)
              (round (+ (VCham-pos-x VCHAM-START) CHAM-SPEED)))
(define (update-animal-pos-x va)
  (modulo
   (round (+ (animal-pos-x va) (animal-speed va)))
   (animal-pos-x-max va)))


; VAnimal -> Number
; 获取当前动物的快乐指数
(check-expect (update-happy VCAT-START)
              (- (VCat-happy VCAT-START) HAPPY-SPEED))
(check-expect (update-happy (make-VCat 0 (+ 20 HAPPY-MAX_HEIGHT)))
              HAPPY-MAX_HEIGHT)
(check-expect (update-happy (make-VCham RED 0 (- 20 HAPPY-MAX_HEIGHT)))
              0)
(define (update-happy va)
  (cond
  [(<= (animal-happy va) 0) 0]
  [(> (animal-happy va) HAPPY-MAX_HEIGHT) HAPPY-MAX_HEIGHT]
  [else (- (animal-happy va) HAPPY-SPEED)]))


; VAnimal KeyEvent -> VAnimal
; 通过按键来更新动物的状态
(check-expect (key-handler (make-VCat 0 80) "down") (make-VCat 0 83))
(check-expect (key-handler (make-VCat 0 80) "up") (make-VCat 0 85))
(check-expect (key-handler (make-VCat 0 100) "up") (make-VCat 0 100))
(check-expect (key-handler (make-VCat 0 80) "r") (make-VCat 0 80))
(check-expect (key-handler (make-VCat 0 80) "g") (make-VCat 0 80))
(check-expect (key-handler (make-VCat 0 80) "b") (make-VCat 0 80))
(check-expect (key-handler (make-VCham RED 0 80) "down") (make-VCham RED 0 83))
(check-expect (key-handler (make-VCham RED 0 80) "up") (make-VCham RED 0 80))
(check-expect (key-handler (make-VCham RED 0 100) "down") (make-VCham RED 0 100))
(check-expect (key-handler (make-VCham RED 0 80) "r") (make-VCham RED 0 80))
(check-expect (key-handler (make-VCham RED 0 80) "g") (make-VCham GREEN 0 80))
(check-expect (key-handler (make-VCham RED 0 80) "b") (make-VCham BLUE 0 80))
(define (key-handler va key)
  (cond
    [(VCat? va) (make-VCat (animal-pos-x va)
                           (cond
                             [(key=? key "up") (happy-increase-score va HAPPY-INCREASE_UP)]
                             [(key=? key "down") (happy-increase-score va HAPPY-INCREASE_DOWN)]
                             [else (VCat-happy va)]))]
    [(VCham? va) (make-VCham (cond
                               [(key=? key "r") RED]
                               [(key=? key "g") GREEN]
                               [(key=? key "b") BLUE]
                               [else (VCham-color va)])
                             (animal-pos-x va)
                             (cond
                               [(key=? key "down") (happy-increase-score va HAPPY-INCREASE_DOWN)]
                               [else (VCham-happy va)]))]))

; VAnimal Number -> Number
; 根据 add 的值来以不同程度增加动物的快乐指数
; 如果超过了 MAX_HEIGHT 就输出 MAX_HEIGHT
(check-expect (happy-increase-score (make-VCat 50 (+ HAPPY-MAX_HEIGHT 20)) HAPPY-INCREASE_DOWN)
              HAPPY-MAX_HEIGHT)
(check-expect (happy-increase-score (make-VCham RED 20 30) HAPPY-INCREASE_UP)
              35)
(define (happy-increase-score va add)
  (if (> (+ (animal-happy va) add) HAPPY-MAX_HEIGHT)
      HAPPY-MAX_HEIGHT
      (+ (animal-happy va) add)))

;; Any -> Boolean
;; 检查是否为 vanimal 集合的元素
(check-expect (vanimal? (make-VCat 20 100)) #true)
(check-expect (vanimal? (make-VCham RED 30 100)) #true)
(check-expect (vanimal? (make-posn 20 100)) #false)
(check-expect (vanimal? "a") #false)
(define (vanimal? v)
  (or (VCat? v) (VCham? v)))

; VAnimal -> Boolean
; 当动物的快乐指数为 0 就停止程序
(check-expect (end? (make-VCat 20 20)) #false)
(check-expect (end? (make-VCham RED 50 0)) #true)
(define (end? va)
  (= (animal-happy va) 0))