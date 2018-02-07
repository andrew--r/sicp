#lang racket

(define (leaf? item) (not (pair? item)))

(define (fringe items)
  (cond ((null? items) null)
        ((leaf? items) (list items))
        (else (append (fringe (car items)) (fringe (cdr items))))
        )
  )

(module+ test
  (require rackunit)
  (define x (list (list 1 2) (list 3 4)))
  (test-case "2_28 fringe"
    (check-equal? (fringe x) (list 1 2 3 4))
    (check-equal? (fringe (list x x)) (list 1 2 3 4 1 2 3 4))
    )
  )
