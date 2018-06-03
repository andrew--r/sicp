#lang racket
(require compatibility/mlist)

(define (mappend ml item)
  (if (null? ml)
    (mlist item)
    (set-mcar! ml item)))

(define (correct-count-mpairs x)
  (define counted-mpairs (mlist))

  (define (mark-mpair-as-counted mp)
    (set! counted-mpairs (mcons mp counted-mpairs)))

  (define (mpair-counted? mp)
    (define (inner head tail)
      (cond ((eq? mp head) true)
            ((null? tail) false)
            (else (inner (mcar tail) 
                          (mcdr tail)))))
    (if (null? counted-mpairs)
      false
      (inner (mcar counted-mpairs)
           (mcdr counted-mpairs))))

  (define (inner item)
    (cond ((not (mpair? item)) 0)
    ((mpair-counted? item) 0)
    (else (begin
            (mark-mpair-as-counted item)
            (+ (inner (mcar item))
                (inner (mcdr item))
                1)))))
  (inner x))

(module+ test
    (require rackunit)
    (test-case "3_17 correct-count-mpairs"
      (define a (mcons 'a 'a))

      (define three (mcons a (mcons 3 3)))
      (check-equal? (correct-count-mpairs three) 3)

      (define four (mcons a (mcons 'b a)))
      (check-equal? (correct-count-mpairs four) 3)

      (define b (mcons a a))
      (define seven (mcons b b))
      (check-equal? (correct-count-mpairs seven) 3)

      (define infinite (mcons 'a (mcons 'b (mcons 'c 'd))))
      (set-mcdr! (mcdr (mcdr infinite)) infinite)

      (check-equal? (correct-count-mpairs infinite) 3)
    )
  )
