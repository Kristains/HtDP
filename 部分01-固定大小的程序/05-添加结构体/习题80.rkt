#lang racket

(define-struct movie [title director year])

(define (watch m)
  (... (movie-title m) ... (movie-director m) ... (movie-year m) ...))


(define-struct pet [name number])

(define (pat p)
  (... (pet-name p) ... (pet-number p) ...))


(define-struct CD [artist title price])

(define (play cd)
  (... (CD-artist cd) ... (CD-title cd) ... (CD-price cd) ...))


(define-struct sweater [material size color])

(define (buy s)
  (... (sweater-material s) ... (sweater-size s) ... (sweater-color s) ...))
