#lang racket

(define (last-pair list)
  (if (null? (cdr list))
      list
      (last-pair (cdr list))))

(module+ test
  (require rackunit)
  (test-case "2_17 last-pair"
    (check-equal? (last-pair (list 1 2 3)) (list 3))
    (check-equal? (last-pair (list 23 72 149 34)) (list 34))
    ))
