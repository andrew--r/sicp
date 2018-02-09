#lang racket

(provide accumulate)

(define (accumulate fn initial sequence)
  (if (null? sequence)
      initial
      (fn (car sequence)
          (accumulate fn initial (cdr sequence))
          )
      )
  )

(module+ test
  (require rackunit)
  (test-case
    "accumulate"
    (check-equal? (accumulate + 0 (list 1 2 3 4 5)) 15)
    (check-equal? (accumulate * 1 (list 1 2 3 4 5)) 120)
    )
  )
