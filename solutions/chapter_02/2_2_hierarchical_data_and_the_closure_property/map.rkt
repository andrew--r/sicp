#lang racket

(provide map)
(define (map fn items)
  (if (null? items)
      null
      (cons (fn (car items))
            (map fn (cdr items))
            )
      )
  )

(module+ test
  (require rackunit)
  (test-case "2_21 map"
    (check-equal? (map (lambda (x) (* x 2)) (list 1 2 3 4)) (list 2 4 6 8))
    )
  )
