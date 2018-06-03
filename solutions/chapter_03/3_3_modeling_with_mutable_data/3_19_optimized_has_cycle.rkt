#lang racket
(require compatibility/mlist)
(require "3_13_make_cycle.rkt")

(define (has-cycle? sequence)
  (define (move-tortoise tortoise)
    (mcdr tortoise))

  (define (move-hare hare)
    (define hare-cdr (mcdr hare))
    (cond ((null? hare-cdr) hare)
          ((null? (mcdr hare-cdr)) hare-cdr)
          (else (mcdr hare-cdr))
          ))

  (define (iter tortoise hare)
    (define same (eq? (mcdr tortoise) (mcdr hare)))
    (cond ((and same (null? (mcdr tortoise))) false)
          (same true)
          (else (iter (move-tortoise tortoise) (move-hare hare)))
          ))

  (iter (move-tortoise sequence) (move-hare sequence)))

(module+ test
    (require rackunit)
    (test-case "3_19 has-cycle?"
      (define cycle (make-cycle (mlist 1 2 3)))
      (check-equal? (has-cycle? cycle) true)
      (check-equal? (has-cycle? (mappend (mlist 'a 'b) cycle)) true)
      (check-equal? (has-cycle? (mlist 1 2 3)) false)
      (check-equal? (has-cycle? (mlist 1 2 3 1 2 3)) false)
    ))
