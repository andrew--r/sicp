#lang racket

(define (make-monitored fn)
  (let ((calls-amount 0))
    (lambda (n)
      (cond
        ((eq? n 'reset-count) (set! calls-amount 0))
        ((eq? n 'how-many-calls?) calls-amount)
        (else
          (set! calls-amount (+ calls-amount 1))
          (fn n)))
      )
    )
  )

(module+ test
  (require rackunit)
  (test-case "3_2 make-monitored"
    (define (square n) (* n n))
    (define s (make-monitored square))

    (check-equal? (s 'how-many-calls?) 0)
    (check-equal? (s 2) 4)
    (check-equal? (s 3) 9)
    (check-equal? (s 'how-many-calls?) 2)
    (check-equal? (s 10) 100)
    (check-equal? (s 'how-many-calls?) 3)
    (s 'reset-count)
    (check-equal? (s 'how-many-calls?) 0)
  )
)
