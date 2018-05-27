#lang racket

(define (make-secure-account balance account-password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "You don’t have enough money"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch password command)
    (if (eq? account-password password)
      (cond ((eq? command 'withdraw) withdraw)
            ((eq? command 'deposit) deposit))
      (lambda (n) "Invalid password")))

  dispatch
)

(module+ test
    (require rackunit)
    (test-case "3_3 make-secure-account"
      (define account (make-secure-account 100 'pass))
      (check-equal? ((account 'pass 'withdraw) 40) 60)
      (check-equal? ((account 'wrong-pass 'withdraw) 40) "Invalid password")
      (check-equal? ((account 'pass 'deposit) 5) 65)
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
    )
  )
