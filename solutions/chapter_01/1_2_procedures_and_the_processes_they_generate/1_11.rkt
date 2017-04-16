#lang racket

; A function f is defined by the rule that f(n)=n if n<3
; and f(n)=f(n−1)+f(n−2)+f(n−3) if n≥3.
; Write a procedure that computes f by means of a recursive process.
; Write a procedure that computes f by means of an iterative process.

(define (f-recursive n)
  (cond ((< n 3) n)
        (else (+ (f-recursive (- n 1))
                 (f-recursive (- n 2))
                 (f-recursive (- n 3))))))

(define (f-iterative n)
  (define (f-iter current a b c)
    (cond ((= current n) (+ a b))
          (else (f-iter (+ current 1) (+ a b c) a b))))
  (f-iter 1 1 0 0))

(module+ test
  (require rackunit)
  (test-case "1_11 (f-recursive n)"
    (check-equal? (f-recursive 1) 1)
    (check-equal? (f-recursive 2) 2)
    (check-equal? (f-recursive 3) 3)
    (check-equal? (f-recursive 4) 6)
    (check-equal? (f-recursive 5) 11)
    (check-equal? (f-recursive 6) 20)
    (check-equal? (f-recursive 7) 37))
  (test-case "1_11 (f-iterative n)"
    (check-equal? (f-iterative 1) 1)
    (check-equal? (f-iterative 2) 2)
    (check-equal? (f-iterative 3) 3)
    (check-equal? (f-iterative 4) 6)
    (check-equal? (f-iterative 5) 11)
    (check-equal? (f-iterative 6) 20)
    (check-equal? (f-iterative 7) 37)))
