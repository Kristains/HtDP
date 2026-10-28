;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 习题117) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; 解释下列语句为什么在语法上是非法的表达式

(3 + 4)
;; - 3 和 4 是 values（值），而 value（值）是 expr（表达式）
;; - + 是一个 primitive（基元）
;; - 但 (3 + 4) 不匹配 (primitive expr expr ...)：
;;   首位置应为 primitive，而 3 是 value
;; - 所以 (3 + 4) 不是合法表达式

number?
;; - number? 是一个 primitive（基元），不是 variable
;; - 单独的 primitive 不匹配任何产生式（primitive 只能出现在应用形式中）
;; - 所以 number? 不是合法表达式

(x)
;; - 带括号，不是 variable 或 value
;; - 首位置 x 是 variable，但 (variable expr expr ...) 需要至少一个参数，
;;   而 (x) 没有参数
;; - 所以 (x) 不是合法表达式
