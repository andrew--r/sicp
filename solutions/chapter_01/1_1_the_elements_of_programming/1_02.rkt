#lang racket

; Translate the following expression into prefix form: (see images/1_02.png)

(define solution (
  /
  (+ 5 4 (- 2 (- 3 (+ 6 4/5))))
  (* 3 (- 6 2) (- 2 7))
))

(module+ test
  (require rackunit)

  (test-case
    "1_02"
    (check-equal? solution -37/150)
  )
)
