#lang racket

(define (leaf? item) (not (pair? item)))

(provide enumerate-tree)
(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((leaf? tree) (list tree))
        (else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))
        )
  )

(module+ test
  (require rackunit)
  (define x (list (list 1 2) (list 3 4)))
  (test-case "enumerate-tree"
    (check-equal? (enumerate-tree x) (list 1 2 3 4))
    (check-equal? (enumerate-tree (list x x)) (list 1 2 3 4 1 2 3 4))
    )
  )
