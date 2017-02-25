#lang racket

; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

(define (square x) (* x x))

(module+ test
  (require rackunit)

  (test-case
    "1_03 square"
    (check-equal? (square 0) 0)
    (check-equal? (square 1) 1)
    (check-equal? (square 2) 4)
    (check-equal? (square 3) 9)
    (check-equal? (square 4) 16)
    (check-equal? (square 10) 100)
  )
)

(define (sum-of-squares x y) (+ (square x) (square y)))

(module+ test
  (require rackunit)

  (test-case
    "1_03 square"
    (check-equal? (sum-of-squares 0 0) 0)
    (check-equal? (sum-of-squares 0 1) 1)
    (check-equal? (sum-of-squares 1 1) 2)
    (check-equal? (sum-of-squares 1 2) 5)
    (check-equal? (sum-of-squares 1 3) 10)
    (check-equal? (sum-of-squares 2 2) 8)
    (check-equal? (sum-of-squares 3 5) 34)
    (check-equal? (sum-of-squares 2 10) 104)
  )
)

(define
  (sum-of-two-greater-squares x y z)
  (cond
    ((= (min x y z) x) (sum-of-squares y z))
    ((= (min x y z) y) (sum-of-squares x z))
    ((= (min x y z) z) (sum-of-squares x y))
  )
)

(module+ test
  (require rackunit)

  (test-case
    "1_03"
    (check-equal? (sum-of-two-greater-squares 1 2 3) 13)
    (check-equal? (sum-of-two-greater-squares 1 1 3) 10)
    (check-equal? (sum-of-two-greater-squares 2 2 2) 8)
    (check-equal? (sum-of-two-greater-squares 1 3 3) 18)
    (check-equal? (sum-of-two-greater-squares 10 9 10) 200)
  )
)
