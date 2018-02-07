#lang racket

(require "filter.rkt")

(define (same-parity first . tail)
  (cons
    first
    (filter tail (lambda (item) (= (remainder first 2) (remainder item 2))))
    )
  )

(module+ test
  (require rackunit)
  (test-case "2_20 same-parity"
    (check-equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7))
    (check-equal? (same-parity 2 3 4 5 6 7) (list 2 4 6))
    )
  )
