#lang racket

(define (make-accumulator value)
  (lambda (n) (set! value (+ value n)) value))

(module+ test
  (require rackunit)
  (test-case "3_1 make-accumulator"
    (define A (make-accumulator 5))
    (check-equal? (A 10) 15)
    (check-equal? (A 2) 17)
    (check-equal? (A 30) 47)
    )
  )
