#lang racket

(define x (list 1 2 3))
(define y (list 4 5 6))

(module+ test
  (require rackunit)
  (test-case "2_26"
    (check-equal? (append x y) (list 1 2 3 4 5 6))
    (check-equal? (cons x y) (list (list 1 2 3) 4 5 6))
    (check-equal? (list x y) (list (list 1 2 3) (list 4 5 6)))
    )
  )