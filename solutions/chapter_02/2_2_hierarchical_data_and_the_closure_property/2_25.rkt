#lang racket

(define a (list 1 3 (list 5 7) 9))
(define b (list (list 7)))
(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(module+ test
  (require rackunit)
  (test-case "2_25"
    (check-equal? (car (cdr (car (cdr (cdr a))))) 7)
    (check-equal? (car (car b)) 7)
    (check-equal? (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c)))))))))))) 7)
    )
  )