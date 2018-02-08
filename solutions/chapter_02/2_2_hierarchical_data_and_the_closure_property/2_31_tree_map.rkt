#lang racket

(require "map.rkt")

(define (tree-map fn tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (fn tree))
        (else (map (lambda (t) (tree-map fn t)) tree))
        )
  )

(module+ test
  (require rackunit)
  (test-case
    "2_31 tree map"
    (define tree (list 1 (list 2 (list 3 4) 5 ) (list 6 7)))
    (define (square x) (* x x))
    (define (square-tree tree) (tree-map square tree))
    (check-equal? (square-tree tree) (list 1 (list 4 (list 9 16) 25) (list 36 49)))
    )
  )
