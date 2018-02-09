#lang racket

(require "accumulate.rkt")

(define (map fn sequence)
  (accumulate (lambda (x y) (cons (fn x) y)) null sequence)
  )

(module+ test
  (require rackunit)
  (test-case
    "2_33 map"
    (check-equal? (map (lambda (x) (* x x)) (list 1 2 3 4 5)) (list 1 4 9 16 25))
    )
  )

(define (append sequence1 sequence2)
  (accumulate cons sequence2 sequence1)
  )

(module+ test
  (require rackunit)
  (test-case
    "2_33 append"
    (check-equal? (append (list 1 2) (list 3 4 5)) (list 1 2 3 4 5))
    )
  )

(define (length sequence)
  (accumulate (lambda (item result) (+ result 1)) 0 sequence)
  )

(module+ test
  (require rackunit)
  (test-case
    "2_33 length"
    (check-equal? (length (list 1 2 3 4)) 4)
    )
  )
