#lang racket

; Newton’s method for cube roots is based on the fact that if yy is an approximation
; to the cube root of xx, then a better approximation is given by the value (see 1_08.png).
; Use this formula to implement a cube-root procedure analogous to the square-root procedure.

(define (cube-root x)
  (define (square x) (* x x))
  (define (good-enough? guess prev-guess)
    (< (abs (- prev-guess guess)) 0.01))
  (define (improve guess)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))
  (define (cube-root-iter guess prev-guess)
    (if (good-enough? guess prev-guess)
        guess
        (cube-root-iter (improve guess) guess)))
  (cube-root-iter 1.0 x))

(module+ test
  (require rackunit)
 
  (test-case
    "1_08"

    (check-equal? (round (cube-root 8)) 2.0)
    (check-equal? (round (cube-root 27)) 3.0)
    (check-equal? (round (cube-root 64)) 4.0)
    (check-equal? (round (cube-root 125)) 5.0)
    (check-equal? (round (cube-root 1000)) 10.0)
  )
)