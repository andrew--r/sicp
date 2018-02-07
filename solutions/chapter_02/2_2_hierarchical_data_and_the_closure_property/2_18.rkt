#lang racket

(define (reverse items)
  (define (iter l result)
    (if (null? l)
        result
        (iter (cdr l) (cons (car l) result))
        )
    )

  (iter items (list))
  )

(module+ test
  (require rackunit)
  (test-case "2_18 reverse"
    (check-equal? (reverse (list 1 2 3)) (list 3 2 1))
    (check-equal? (reverse (list 5 10 15 20 30 50)) (list 50 30 20 15 10 5))
    ))
