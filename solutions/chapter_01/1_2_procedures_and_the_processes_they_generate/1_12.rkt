#lang racket

; Write a procedure that computes elements of Pascal’s triangle by means of a recursive process.

(define (pascal-triangle row column)
  (cond ((> column row) 0)
        ((< column 0) 0)
        ((= column 1) 1)
        ((+ (pascal-triangle (- row 1) (- column 1))
            (pascal-triangle (- row 1) column)))))

(module+ test
  (require rackunit)
  (test-case "1_12 calculate-pascal-triangle"
    (check-equal? (pascal-triangle 0 0) 0)
    (check-equal? (pascal-triangle 1 1) 1)
    (check-equal? (pascal-triangle 1 2) 0)
    (check-equal? (pascal-triangle 2 1) 1)
    (check-equal? (pascal-triangle 2 2) 1)
    (check-equal? (pascal-triangle 3 1) 1)
    (check-equal? (pascal-triangle 3 2) 2)
    (check-equal? (pascal-triangle 3 3) 1)
    (check-equal? (pascal-triangle 4 1) 1)
    (check-equal? (pascal-triangle 4 2) 3)
    (check-equal? (pascal-triangle 4 3) 3)
    (check-equal? (pascal-triangle 4 4) 1)
    (check-equal? (pascal-triangle 5 1) 1)
    (check-equal? (pascal-triangle 5 2) 4)
    (check-equal? (pascal-triangle 5 3) 6)
    (check-equal? (pascal-triangle 5 4) 4)
    (check-equal? (pascal-triangle 5 5) 1)))

