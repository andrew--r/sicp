#lang racket

(define (make-secure-account balance account-password)
  (let ((failed-access-attempts-count 0))
    (define (withdraw amount)
        (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "You don’t have enough money"))

    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    
    (define (call-the-cops) "Cops are called")

    (define (dispatch password command)
        (if (eq? account-password password)
            (cond ((eq? command 'withdraw) withdraw)
                    ((eq? command 'deposit) deposit))
            (lambda args
            (if (> failed-access-attempts-count 7)
                (call-the-cops)
                (begin
                    (set! failed-access-attempts-count (+ failed-access-attempts-count 1))
                    "Invalid password"))
            )))

    dispatch)
  )

(module+ test
    (require rackunit)
    (test-case "3_3 make-secure-account"
      (define account (make-secure-account 100 'pass))
      (check-equal? ((account 'pass 'withdraw) 40) 60)
      (check-equal? ((account 'wrong-pass 'withdraw) 40) "Invalid password")
      (check-equal? ((account 'pass 'deposit) 5) 65)

      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Invalid password")
      (check-equal? ((account 'wrong-pass 'deposit) 5) "Cops are called")
    )
  )
