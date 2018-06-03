#lang racket
(require compatibility/mlist)

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define (count-mpairs x)
  (if (not (mpair? x))
      0
      (+ (count-mpairs (mcar x))
        (count-mpairs (mcdr x))
        1)))

(module+ test
    (require rackunit)
    (test-case "3_16 count-pairs"
      (define a (cons 'a 'a))

      (define three (cons a (cons 3 3)))
      (check-equal? (count-pairs three) 3)

      (define four (cons a (cons 'b a)))
      (check-equal? (count-pairs four) 4)

      (define b (cons a a))
      (define seven (cons b b))
      (check-equal? (count-pairs seven) 7)

      (define infinite (mcons 'a (mcons 'b (mcons 'c 'd))))
      (set-mcdr! (mcdr (mcdr infinite)) infinite)

      ; will execute infinitely
      ; (check-equal? (count-mpairs infinite) 0)
    )
  )
