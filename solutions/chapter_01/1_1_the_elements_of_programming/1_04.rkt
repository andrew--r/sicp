#lang racket

; Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; this procedure takes two numbers, checks the second number sign and uses + (if the second number is positive) or - (if it is negative) operator to sum the first number with an absolute value of the second number.

(module+ test
  (require rackunit)
 
  (test-case
    "1_04"

    (check-equal? (a-plus-abs-b 2 3) 5)
    (check-equal? (a-plus-abs-b 2 -3) 5)
  )
)