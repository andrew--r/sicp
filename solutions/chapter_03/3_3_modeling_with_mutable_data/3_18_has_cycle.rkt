#lang racket
(require compatibility/mlist)
(require "3_13_make_cycle.rkt")
(require "make_mpairs_storage.rkt")

(define (has-cycle? sequence)
  (define visited-mpairs (make-mpairs-storage))

  (define (iter sequence)
    (cond ((null? sequence) false)
          (((visited-mpairs 'contains?) sequence) true)
          (else (begin
            ((visited-mpairs 'add) sequence)
            (iter (mcdr sequence))))
          ))

  (iter sequence))

(module+ test
    (require rackunit)
    (test-case "3_18 has-cycle?"
      (define cycle (make-cycle (mlist 1 2 3)))
      (check-equal? (has-cycle? cycle) true)
      (check-equal? (has-cycle? (mappend (mlist 'a 'b) cycle)) true)
      (check-equal? (has-cycle? (mlist 1 2 3)) false)
    ))
