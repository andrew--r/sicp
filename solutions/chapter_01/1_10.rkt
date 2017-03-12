#lang racket

; The following procedure computes a mathematical function called Ackermann’s function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

; What are the values of the following expressions?

(A 1 10) ; 1024
(A 2 4) ; 65536
(A 3 3) ; 65536

; Consider the following procedures, where A is the procedure defined above:

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))

; Give concise mathematical definitions for the functions computed
; by the procedures f, g, and h for positive integer values of nn.
; For example, (k n) computes 5n^2.


; SOLUTION

; (f n)
; 2n
;
; example:
(module+ test
  (require rackunit)
 
  (test-case
    "1_10 (f n)"

    (check-equal? (f 2) 4)
    (check-equal? (f 3) 6)
    (check-equal? (f 4) 8)
    (check-equal? (f 5) 10)
    (check-equal? (f 6) 12)
    (check-equal? (f 7) 14)
  )
)



; (g n)
; n^2
;
; example:
(module+ test
  (require rackunit)
 
  (test-case
    "1_10 (g n)"

    (check-equal? (g 2) 4)
    (check-equal? (g 3) 8)
    (check-equal? (g 4) 16)
    (check-equal? (g 5) 32)
    (check-equal? (g 6) 64)
    (check-equal? (g 7) 128)
  )
)

; (h n)
; n^(n^(n^...)) n - 1 times
;
; example:
(module+ test
  (require rackunit)
 
  (test-case
    "1_10 (h n)"

    (check-equal? (h 1) 2)
    (check-equal? (h 2) 4)
    (check-equal? (h 3) 16)
    (check-equal? (h 4) 65536)
  )
)
