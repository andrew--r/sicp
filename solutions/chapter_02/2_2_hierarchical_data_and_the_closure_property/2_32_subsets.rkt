#lang racket

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
                            (cond ((null? x) (list (car s)))
                                  (else (append (list (car s)) x))
                                  )
                            )
                          rest)
                )
        )
      )
  )

(module+ test
  (require rackunit)
  (test-case
    "2_32 subsets"
    (check-equal? (subsets (list 1)) (list (list) (list 1)))
    (check-equal? (subsets (list 1 2)) (list (list) (list 2) (list 1) (list 1 2)))
    (check-equal? (subsets (list 1 2 3)) (list (list) (list 3) (list 2) (list 2 3) (list 1) (list 1 3) (list 1 2) (list 1 2 3)))
    )
  )
