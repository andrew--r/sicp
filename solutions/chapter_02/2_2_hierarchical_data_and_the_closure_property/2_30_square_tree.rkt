#lang racket

(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))
                    )
              )
        )
  )

(module+ test
  (require rackunit)
  (test-case
    "2_30 square tree"
    (define tree (list 1 (list 2 (list 3 4) 5 ) (list 6 7)))
    (check-equal? (square-tree tree) (list 1 (list 4 (list 9 16) 25) (list 36 49)))
    )
  )

(require "map.rkt")

(define (square-tree2 tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (map (lambda (t) (square-tree t)) tree))
        )
  )

(module+ test
  (require rackunit)
  (test-case
    "2_30 square tree 2"
    (define tree (list 1 (list 2 (list 3 4) 5 ) (list 6 7)))
    (check-equal? (square-tree2 tree) (list 1 (list 4 (list 9 16) 25) (list 36 49)))
    )
  )
