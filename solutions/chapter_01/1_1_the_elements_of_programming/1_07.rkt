#lang racket

; The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers.
; Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate
; for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers.
; An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop
; when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this
; work better for small and large numbers?

(define (square x) (* x x))

(define (average x y) 
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; solution

(define (better-good-enough? guess prev-guess)
  (< (abs (- prev-guess guess)) 0.01))

(define (better-sqrt-iter guess prev-guess x)
  (if (better-good-enough? guess prev-guess)
      guess
      (better-sqrt-iter (improve guess x) guess x)))

(define (better-sqrt x)
  (better-sqrt-iter 1.0 x x))

(module+ test
  (require rackunit)
 
  (test-case
    "1_07"

    (check-equal? (round (better-sqrt 4)) (round (sqrt 4)))
    (check-equal? (round (better-sqrt 9)) (round (sqrt 9)))
    (check-equal? (round (better-sqrt 16)) (round (sqrt 16)))
  )
)