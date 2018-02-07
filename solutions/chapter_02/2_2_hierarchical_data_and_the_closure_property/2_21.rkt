#lang racket

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

(define (square x) (* x x))

(module+ test
  (require rackunit)
  (test-case "2_21 square"
    (check-equal? (square 2) 4)
    (check-equal? (square 3) 9)
    (check-equal? (square 5) 25)
    )
  )

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))
            (square-list (cdr items))
            )
      )
  )

(module+ test
  (require rackunit)
  (test-case "2_21 square-list"
    (check-equal? (square-list (list 1 2 3 4)) (list 1 4 9 16))
    )
  )

(define (square-list2 items)
  (map square items))

(module+ test
  (require rackunit)
  (test-case "2_21 square-list2"
    (check-equal? (square-list2 (list 1 2 3 4)) (list 1 4 9 16))
    )
  )