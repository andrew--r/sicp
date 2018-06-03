#lang racket
(require compatibility/mlist)

(define (correct-count-mpairs x)
  (define counted-mpairs
    (let ((counted-mpairs-list (mlist)))
      (define (contains? item)
        (define (inner temp-list)
          (cond ((null? temp-list) false)
                ((eq? (mcar temp-list) item) true)
                (else (inner (mcdr temp-list)))))
        (inner counted-mpairs-list))
      
      (define (add mp)
        (set! counted-mpairs-list (mcons mp counted-mpairs-list)))

      (lambda (message)
        (cond ((eq? message 'contains?) contains?)
              ((eq? message 'add) add)
              (else (error "Unknown operation on counted-mpairs"))))))

  (define (inner item)
    (cond ((not (mpair? item)) 0)
    (((counted-mpairs 'contains?) item) 0)
    (else (begin
            ((counted-mpairs 'add) item)
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
