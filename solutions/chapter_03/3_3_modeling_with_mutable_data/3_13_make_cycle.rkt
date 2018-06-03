#lang racket
(require compatibility/mlist)

(define (last-mpair x)
  (if (null? x)
    x
    (mlist-tail x (- (mlength x) 1))))

(define (make-cycle x)
  (set-mcdr! (last-mpair x) x)
  x)

; (define z (make-cycle (list 'a 'b 'c)))
; What happens if we try to compute (last-pair z)?

; The program will enter an infinite loop trying to reach the list end, since the last pair is a pointer to the list itself.
