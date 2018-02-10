#lang racket

(require "accumulate.rkt")
(require "map.rkt")
(require "enumerate_tree.rkt")

(define (count-leaves tree)
  (accumulate (lambda (x result) (+ x result)) 0 (map (lambda (x) 1) (enumerate-tree tree)))
  )

(module+ test
  (require rackunit)
  (test-case
    "2_35 count leaves"
    (define tree (list 1 (list 2 (list 3 4) 5 ) (list 6 7)))
    (check-equal? (count-leaves tree) 7)
    )
  )

