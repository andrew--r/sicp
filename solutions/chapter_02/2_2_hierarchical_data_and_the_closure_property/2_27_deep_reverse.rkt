#lang racket

(require "map.rkt")
(require "2_18_reverse.rkt")

(define (deep-reverse items)
  (reverse (map (lambda (x) (if (pair? x) (deep-reverse x) x)) items))
  )

(module+ test
  (require rackunit)
  (test-case "2_27 deep-reverse"
    (check-equal? (deep-reverse (list (list 1 2) (list 3 4))) (list (list 4 3) (list 2 1)))
    (check-equal? (deep-reverse (list (list 1 2 (list 3 4)) (list 5 (list 6 7)))) (list (list (list 7 6) 5) (list (list 4 3) 2 1)))
    )
  )