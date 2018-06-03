#lang racket
(require compatibility/mlist)

(provide last-mpair)

(define (last-mpair x)
  (if (null? x)
    x
    (mlist-tail x (- (mlength x) 1))))

(module+ test
  (require rackunit)
  (test-case "last-mpair"
    (check-equal? (last-mpair (mlist 1 2 3 4 5 6 7)) (mcons 7 null))
    (check-equal? (last-mpair (mlist 1 2 3)) (mcons 3 null))
  ))