#lang racket

(define (make-mobile left right)
  (list left right)
  )

(define (make-branch length structure)
  (list length structure)
  )

(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (car (cdr mobile)))

(define (branch-length branch) (car branch))
(define (branch-structure branch) (car (cdr branch)))
(define (branch? item) (and (list? item)
                            (number? (branch-length item))
                            )
  )
(define (mobile? item) (and (list? item)
                            (branch? (left-branch item))
                            (branch? (right-branch item))
                            )
  )

(define (total-weight mobile)
  (define (branch-weight branch)
    (define structure (branch-structure branch))
    (if (mobile? structure)
        (total-weight structure)
        structure)
    )
  
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))
     )
  )

(module+ test
  (require rackunit)
  (test-case "2_29 binary mobile total weight"
    (define mobile (make-mobile (make-branch 2 2) (make-branch 3 5)))
    (check-equal? (total-weight mobile) 7)
    (check-equal? (total-weight (make-mobile (make-branch 1 mobile) (make-branch 1 1))) 8)
    )
  )

(define (balanced? mobile)
  (define (branch-sum branch)
    (define structure (branch-structure branch))
    (* (branch-length branch)
       (if (mobile? structure)
           (total-weight structure)
           structure)
       )
    )

  (= (branch-sum (left-branch mobile))
     (branch-sum (right-branch mobile))
     )
  )

(module+ test
  (require rackunit)
  (test-case "2_29 binary mobile balance"
    (define mobile (make-mobile (make-branch 2 2) (make-branch 1 4)))
    (check-equal? (balanced? mobile) true)
    (check-equal? (balanced? (make-mobile (make-branch 1 mobile) (make-branch 1 1))) false)
    )
  )