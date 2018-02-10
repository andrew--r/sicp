#lang racket

(require "accumulate.rkt")
(require "map.rkt")

(define (accumulate-n fn initial sequence)
  (if (null? (car sequence))
      null
      (cons (accumulate fn initial (map (lambda (subsequence) (car subsequence)) sequence))
            (accumulate-n fn initial (map (lambda (subsequence) (cdr subsequence)) sequence))
            )
      )
  )

(module+ test
  (require rackunit)
  (test-case
    "2_36 accumulate-n"
    (check-equal? (accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12))) (list 22 26 30))
    )
  )
