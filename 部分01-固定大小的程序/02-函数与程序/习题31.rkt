#lang racket
(require 2htdp/batch-io)

(define (letter fst lst signature-name)
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst)
   "\n\n"
   (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))


(define FST "./files/fst.txt")
(define LST "./files/lst.txt")
(define SIGNATURE "./files/signature.txt")
(define OUT "./files/out.txt")

;; Application
(write-file FST "Matthew")
(write-file LST "Fisler")
(write-file SIGNATURE "Felleisen")

(main FST LST SIGNATURE OUT)

(write-file 'stdout (string-append (read-file OUT) "\n"))
